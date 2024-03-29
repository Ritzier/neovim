local opt = vim.opt

opt.autoindent = true
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.cmdheight = 0
opt.completeopt = "menuone,noselect"
opt.conceallevel = 0
opt.confirm = true
opt.cursorline = true
opt.cursorcolumn = true
opt.expandtab = true
opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
--
opt.foldcolumn = "0"
opt.foldenable = false
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.formatoptions = "jqlnt"
opt.hidden = true
opt.hlsearch = false
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.joinspaces = false
opt.laststatus = 3
opt.list = true
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrollback = 100000
opt.scrolloff = 9
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true
opt.shiftwidth = 2
opt.shortmess:append  { w = true, I = true, c = true, C = true }
opt.showcmd = false
opt.showmode = false
opt.sidescrolloff = 9
--
opt.signcolumn = "yes"
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.timeoutlen = 300
opt.title = true
opt.undofile = true
opt.updatetime = 200
opt.wildmode = "longest:full,full"

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.markdown_recommended_style = 0
