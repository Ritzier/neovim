vim.bo.shiftwidth = 4
vim.bo.tabstop = 4
vim.bo.softtabstop = 4
vim.bo.expandtab = true
vim.bo.textwidth = 0
vim.bo.autoindent = true
vim.bo.smartindent = true

local default_opts = { noremap = true, silent = true }
vim.keymap.set("n", "1", ":!python3 %", default_opts)
