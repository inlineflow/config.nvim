local M = {}

M.setup = function()
  vim.keymap.set('n', '<leader>fq', function()
    local diagnostics = vim.diagnostic.get(0)
    local current_win = vim.api.nvim_get_current_win()
    local qf_diags = vim.diagnostic.toqflist(diagnostics)
    if #qf_diags > 0 then
      vim.fn.setqflist(qf_diags, 'r')
      vim.cmd("copen")
      vim.api.nvim_set_current_win(current_win)
    else
      vim.cmd("cclose")
    end
  end)
end

return M
