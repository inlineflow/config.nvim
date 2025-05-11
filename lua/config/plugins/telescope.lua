local telescope = require('telescope');

return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  -- or                              , branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
  },
  config = function()
    require('telescope').setup {
      pickers = {
        lsp_references = {
          theme = "ivy"
        }
      },
      extensions = {
        fzf = {}
      }
    }

    require('telescope').load_extension('fzf')

    local builtin = require('telescope.builtin')
    vim.keymap.set("n", "<space>fh", builtin.help_tags)
    vim.keymap.set("n", "<space>fd", builtin.find_files)
    vim.keymap.set("n", "<leader><leader>", builtin.buffers)
    vim.keymap.set('n', "<leader>gd", builtin.diagnostics)
    vim.keymap.set("n", "<space>en", function()
      require('telescope.builtin').find_files {
        cwd = vim.fn.stdpath("config")
      }
    end)

    vim.keymap.set("n", "<space>ep", function()
      require('telescope.builtin').find_files {
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      }
    end)

    vim.keymap.set("n", "<space>fr", require('telescope.builtin').lsp_references)

    require "config.telescope.multigrep".setup()
  end
}
