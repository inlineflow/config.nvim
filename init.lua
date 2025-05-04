require('config.lazy')

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4

vim.opt.autochdir = true

-- vim.cmd [[hi @string guifg=pink]]

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "M-j", "<cmd>cnext<CR>")
vim.keymap.set("n", "M-k", "<cmd>cprev<CR>")
vim.keymap.set("n", "-", "<cmd>Oil<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require "config.git.push".setup()
