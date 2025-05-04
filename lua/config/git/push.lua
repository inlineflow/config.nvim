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

local function print_git()
  local git_dir = get_git_root()
  print(git_dir)
end

M.setup = function()
  vim.keymap.set("n", "<space>hp", function()
      print_git()
    end,
    { noremap = true, silent = true })
  -- vim.keymap.set("n", "<space>hp", function()
  --   print 'hello'
  -- end)
  -- print 'configed'
end

M.setup()
-- print "world"

return M
