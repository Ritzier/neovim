return {
  {
    "neovim/nvim-lspconfig",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "j-hui/fidget.nvim", config = true },
      { "smjonas/inc-rename.nvim", config = true },
      {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
      },
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "folke/neodev.nvim",
    },
    config = require("plugins.lsp.lsp")
  },
}
