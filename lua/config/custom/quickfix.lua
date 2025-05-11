local M = {}

M.local_diagnostics = function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, "buftype") == "quickfix" then
      vim.cmd("cclose")
      return
    end
  end

  local diagnostics = vim.diagnostic.get(0)
  if #diagnostics <= 0 then
    return
  end

  -- print(vim.inspect(diagnostics))

  local current_win = vim.api.nvim_get_current_win()
  local qf_diags = vim.diagnostic.toqflist(diagnostics)
  vim.fn.setqflist(qf_diags, "r")
  vim.cmd("copen")
  vim.defer_fn(function()
    vim.api.nvim_set_current_win(current_win)
  end, 50)
end

M.setup = function()
  vim.keymap.set("n", "<leader>q", M.local_diagnostics)
end

return M
