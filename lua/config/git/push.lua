local M = {}

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
  local command = { 'git', '--no-pager', 'log' }
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

local function make_entries(logs)
  local entries = {}
  local temp = ''
  logs = vim.tbl_filter(function(x) return x ~= '' end, logs)
  for k, v in ipairs(logs) do
    temp = temp .. vim.trim(v) .. '\n'
    if math.fmod(k, 4) == 0 then
      table.insert(entries, temp)
      temp = ''
      -- print(k, v)
    end
  end

  return entries;
end

local function print_git()
  local git_dir = get_git_root()
  local log = git_log(git_dir)
  local raw_logs = vim.split(log, '\n', { trimempty = true })
  local entries = make_entries(raw_logs)
  -- local entries = {}
  -- for k, v in ipairs(raw_logs) do
  --   if v ~= '' then
  --     print(k, v)
  --   end
  -- end
  -- print(entries)
end

M.setup = function()
  vim.keymap.set("n", "<space>hp", function()
      print_git()
    end,
    { noremap = true, silent = true })
end

M.setup()

return M
