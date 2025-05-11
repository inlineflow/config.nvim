local lua_ls = function()
  local capabilities = require("blink.cmp").get_lsp_capabilities()
  require("lspconfig").lua_ls.setup({ capabilities = capabilities })
end

local ts_server = function()
  vim.opt.shiftwidth = 2
  vim.opt.tabstop = 2
  vim.opt.expandtab = true
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  -- vim.opt.runtimepath:append("/home/thrashdev/.nvm/versions/node/v21.7.0/lib/node_modules/typescript-language-server")
  -- vim.opt.runtimepath:append("/home/thrashdev/.nvm/versions/node/v21.2.0/lib/node_modules/typescript-language-server")
  require("lspconfig").ts_ls.setup({
    capabilities = capabilities,
    handlers = {
      ["textDocument/publishDiagnostics"] = function(...) end,
    },
  })
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      lua_ls()
      ts_server()

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          -- local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- if not client then return end
          --
          -- if client.supports_method('textDocument/formatting') then
          --   vim.api.nvim_create_autocmd('BufWritePre', {
          --     buffer = args.buf,
          --     callback = function()
          --       vim.lsp.buf.format({
          --         bufnr = args.buf,
          --         id = client.id,
          --         formatting_options = {
          --           tabSize = vim.opt.shiftwidth:get(),
          --           insertSpaces = vim.opt.expandtab:get(),
          --         }
          --       })
          --     end,
          --   })
          -- end

          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          local builtin = require("telescope.builtin")

          map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
          map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
          map("grr", builtin.lsp_references, "[G]oto [R]eferences")
          map("gri", builtin.lsp_implementations, "[G]oto [I]mplementations")
          map("grd", builtin.lsp_definitions, "[G]oto [D]efinition")
          map("gO", builtin.lsp_document_symbols, "Open Document Symbols")
        end,
      })
    end,
  },
}
