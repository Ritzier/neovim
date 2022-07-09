vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4

local default_opts = { noremap = true, silent = true }
vim.keymap.set("n", "1", ":!python3 %<CR>", default_opts)
