require("impatient")
local g = vim.g
local cmd = vim.cmd
local opt = vim.opt

local disabled_built_ins = {
  'gzip',
  'man',
  'matchit',
  'matchparen',
  'shada_plugin',
  'tarPlugin',
  'tar',
  'zipPlugin',
  'zip',
  'netrwPlugin',
}

for i = 1, 10 do
  g['loaded_' .. disabled_built_ins[i]] = 1
end

opt.scrolloff = 7
opt.wildignore = { '*.o', '*~', '*.pyc' }
opt.wildmode = 'longest,full'
opt.whichwrap:append '<,>,h,l'
opt.inccommand = 'nosplit'
opt.lazyredraw = true
opt.showmatch = true
opt.ignorecase = true
opt.smartcase = true
opt.number = true
opt.relativenumber = true
opt.laststatus = 3
opt.showmode = false
opt.shada = [['20,<50,s10,h,/100]]
opt.hidden = true
opt.shortmess:append 'c'
opt.joinspaces = false
opt.guicursor = [[n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50]]
opt.updatetime = 100
opt.conceallevel = 2
opt.concealcursor = 'nc'
opt.previewheight = 5
opt.undofile = true
opt.synmaxcol = 500
opt.display = 'msgsep'
opt.cursorline = true
opt.cursorcolumn = true
opt.modeline = false
opt.mouse = 'a'
opt.signcolumn = 'yes:1'

opt.termguicolors = true
opt.background = 'light'

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

vim.cmd([[
syntax enable
filetype plugin indent on
]])

vim.cmd('colorscheme spaceduck')
