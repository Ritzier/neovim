return {
  {
    "akinsho/nvim-bufferline.lua",
    after = "catppuccin",
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    config = require("plugins.buffer.config")
  },

  -- scope buffers to tabs
  { "tiagovla/scope.nvim", event = "VeryLazy", opts = {} },
}
