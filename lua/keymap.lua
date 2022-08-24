local keymap = vim.keymap.set
local silent = { silent = true }

keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)

keymap("n", "H", "^", silent)

keymap("v", "<", "<gv", silent)
keymap("v", ">", ">gv", silent)

keymap("n", "<C-s>", ":w<CR>",       silent)
keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

keymap("n", "<CR>", ":noh<CR><CR>", silent)

keymap("n", "<A-j>",   ":BufferLineCycleNext<CR>", silent)
keymap("n", "<A-k>",   ":BufferLineCyclePrev<CR>", silent)
keymap("n", "<A-S-j>", ":BufferLineMoveNext<CR>",  silent)
keymap("n", "<A-S-k>", ":BufferLineMovePrev<CR>",  silent)

keymap("n", "<C-n>", ":NvimTreeToggle<CR>", silent)

-- Easyalign
keymap("n", "ga", ":EasyAlign<CR>", silent)
keymap("x", "ga", ":'<, '>EasyAlign<CR>", silent)

-- LSP
keymap("n", "gd",       "<cmd>Lspsaga preview_definition<CR>",                                 silent)
keymap("n", "gr",       "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)
keymap("n", "K",        "<cmd>Lspsaga hover_doc<cr>",                                          silent)
keymap("n", "gi",       "<cmd>lua vim.lsp.buf.implementation",                                 silent)
keymap("n", "<C-k>",    "<cmd>lua vim.lsp.buf.signature_help",                                 silent)
keymap("n", "<space>e", "<cmd>lua vim.diagnostic.open_float",                                  silent)
