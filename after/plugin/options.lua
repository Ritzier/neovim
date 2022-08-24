local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.undofile = true
opt.ignorecase = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.errorbells = false
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8
opt.joinspaces = false -- No double spaces with join after a dot
opt.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal"
opt.smartindent = true --Smart indent
opt.expandtab = true
opt.smarttab = true
opt.textwidth = 0
opt.autoindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.showtabline = 2
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 1
opt.scrollback = 100000
opt.cursorline = true
opt.cursorcolumn = true
opt.pumheight = 20
opt.numberwidth = 3
g.compeleopt = "menu,menuone,noselct"

vim.opt.shortmess:append('c');
vim.opt.formatoptions:remove('c');
vim.opt.formatoptions:remove('r');
vim.opt.formatoptions:remove('o');
vim.opt.fillchars:append('stl: ');
vim.opt.fillchars:append('eob: ');
vim.opt.fillchars:append('fold: ');
vim.opt.fillchars:append('foldopen: ');
vim.opt.fillchars:append('foldsep: ');
vim.opt.fillchars:append('foldclose:');

opt.path:remove "/usr/include"
opt.path:append "**"

opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

opt.guifont = "JetBrains_Mono_Nerd_Font:h10"
if vim.g.neovide then
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_fullscreen = true
end

vim.cmd('filetype plugin indent on')
