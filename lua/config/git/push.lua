local M = {}
local make_entry = require 'telescope.make_entry'
local finders = require 'telescope.finders'
local sorters = require 'telescope.sorters'
local pickers = require 'telescope.pickers'
local conf = require 'telescope.config'.values
local entry_display = require 'telescope.pickers.entry_display'

local function get_git_root()
  -- print 'running'
  local command = { 'git', 'rev-parse', '--show-toplevel' }
  local result = vim.system(command, {
    text = true,
    cwd = vim.fn.expand('%:p:h')
  }):wait()

  if result.code ~= 0 then
    print('Error: command failed')
    print('Exit code:', result.code)
    print('Stderr:', vim.trim(result.stderr))
    print('Stdout:', vim.trim(result.stdout))
    return nil
  end

  local git_dir = vim.trim(result.stdout)
  if git_dir == '' then
    print("Couldn't get git directory")
    print('Exit code:', result.code)
    print('Stderr:', vim.trim(result.stderr))
    print('Stdout:', vim.trim(result.stdout))
  end

  return git_dir
end

local function git_log(git_dir)
  local command = { 'git', '--no-pager', 'log', '--abbrev-commit', '--date=iso' }
  local result = vim.system(command, {
    text = true,
    cwd = git_dir
  }):wait()

  if result.code ~= 0 then
    print('Error: command failed')
    print('Exit code:', result.code)
    print('Stderr:', vim.trim(result.stderr))
    print('Stdout:', vim.trim(result.stdout))
    return nil
  end

  local log = vim.trim(result.stdout)
  if log == '' then
    print("Couldn't get git directory")
    print('Exit code:', result.code)
    print('Stderr:', vim.trim(result.stderr))
    print('Stdout:', vim.trim(result.stdout))
  end

  return log
end

local function prep_entries(logs)
  local entries = {}
  local temp = {}
  logs = vim.tbl_filter(function(x) return x ~= '' end, logs)
  print(vim.inspect(logs))
  for k, v in ipairs(logs) do
    v = v:gsub("commit ", "")
    v = v:gsub("Author: ", "")
    v = v:gsub("Date: ", "")
    table.insert(temp, v)
    -- temp = temp .. vim.trim(v)
    if math.fmod(k, 4) == 0 then
      local entry = {
        index = tostring(k / 4),
        hash = vim.trim(temp[1]),
        author = vim.trim(temp[2]),
        date = vim.trim(temp[3]),
        note = vim.trim(temp[4]),
      }
      table.insert(entries, entry)
      temp = {}
      -- print(k, v)
    end
  end

  return entries;
end

local function make_entries()
  local git_dir = get_git_root()
  local log = git_log(git_dir)
  local raw_logs = vim.split(log, '\n', { trimempty = true })
  local raw_entries = prep_entries(raw_logs)
  print(vim.inspect(raw_entries))
  return raw_entries
end

local function squash(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()
  local displayer = entry_display.create {
    separator = ' || ',
    items = {
      { width = 2 },
      { width = 40 },
      { width = 25 },
      { width = 20 },
      { remaining = true },
    }
  }

  local make_display = function(entry)
    return displayer({
      entry.search_index,
      entry.hash,
      entry.note,
      entry.date,
      entry.author,
    })
  end


  -- local entry = {
  --   index = math.fmod(k, 4),
  --   hash = vim.trim(temp[1]),
  --   author = vim.trim(temp[2]),
  --   date = vim.trim(temp[3]),
  --   note = vim.trim(temp[4]),
  -- }

  local entry_maker = function(t)
    print("Entry: " .. vim.inspect(t))
    return {
      value = t.note,
      ordinal = t.index,
      display = make_display,
      hash = t.hash,
      author = t.author,
      date = t.date,
      note = t.note,
      search_index = tonumber(t.index),
    }
  end

  local entries = make_entries()
  local finder = finders.new_table {
    results = entries,
    entry_maker = entry_maker
  }

  print(vim.inspect(finder))
  local index_sorter = sorters.Sorter:new {
    scoring_function = function(self, prompt, entry_index)
      -- print(vim.inspect(entry))
      entry_index = tonumber(entry_index)
      if not entry_index then
        vim.notify("Couldn't convert entry to number", vim.log.levels.ERROR)
      end
      if prompt == "" then
        return 0
      end

      local pieces = vim.split(prompt, "  ")
      -- if not pieces then
      --   return 0
      -- end
      -- print(vim.inspect(pieces))
      local prompt_index = tonumber(pieces[1])
      print("Entry in sorter: " .. vim.inspect(entry_index))
      if prompt_index then
        if prompt_index < entry_index then
          return math.huge
        end

        return entry_index + 1 - prompt_index
      end
      if not tonumber(prompt_index) then
        print("Failed to find index, prompt: " .. prompt)
        print("Pieces of prompt: " .. vim.inspect(pieces))
        if prompt_index ~= nil then
          print("Index:" .. tonumber(prompt_index))
        end
        return 0
      end
      local message = pieces[2]
      local entry_index = string.sub(entry_index, 1, 1)


      if not prompt_index then
        return math.huge
      end

      if entry_index <= prompt_index then
        return 0
      end

      return math.huge
    end
  }

  pickers.new(opts, {
    debounce = 100,
    prompt_title = "Git Squash",
    finder = finder,
    -- sorter = conf.generic_sorter {}
    sorter = index_sorter,
    sorting_strategy = "ascending",
  }):find()
end

M.setup = function()
  vim.keymap.set("n", "<space>hp", function()
      squash()
    end,
    { noremap = true, silent = true })
end

M.setup()

return M
