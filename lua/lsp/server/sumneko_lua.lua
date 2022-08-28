local attach = require("lsp.server.default").on_attach
local capabilities = require("lsp.server.default").capabilities

local luadev = require("lua-dev").setup({
  library = {
    vimruntime = true,
    types = true,
    plugins = { "lua-dev.nvim", "plenary.nvim" },
  },
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workpsace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
      },
    },
    on_attach = attach,
    capabilities = capabilities,
  },
})

require("lspconfig")["sumneko_lua"].setup(luadev)
