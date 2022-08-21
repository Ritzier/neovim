local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
require("legendary").setup { include_builtin = true, auto_register_which_key = true }
keymap("n", "<C-p>", "<cmd>lua require('legendary').find()<CR>", default_opts)
