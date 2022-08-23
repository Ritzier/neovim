local opt = {
  library = {
    vimruntime = true,
    types = true,
    plugins = { "lua-dev.nvim", "plenary.nvim" },
  },
  lspconfig = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim', 'bit', 'packer_plugins' },
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
  },
}

return opt
