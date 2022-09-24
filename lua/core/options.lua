local global_local = {
    termguicolors = true,
    mouse = "a",
    errorbells = true,
    visualbell = true,
    hidden = true,
    fileformats = "unix,mac,dos",
    magic = true,
    virtualedit = "block",
    encoding = "utf-8",
    viewoptions = "folds,cursor,curdir,slash,unix",
    sessionoptions = "curdir,help,tabpages,winsize",
    clipboard = "unnamedplus",
    wildignorecase = true,
    wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**",
    backup = false,
    writebackup = false,
    swapfile = false,
    history = 2000,
    shada = "!,'300,<50,@100,s10,h",
    smarttab = true,
    shiftround = true,
    timeout = true,
    ttimeout = true,
    timeoutlen = 500,
    ttimeoutlen = 0,
    updatetime = 100,
    redrawtime = 1500,
    ignorecase = true,
    smartcase = true,
    infercase = true,
    incsearch = true,
    wrapscan = true,
    complete = ".,w,b,k",
    inccommand = "nosplit",
    grepformat = "%f:%l:%c:%m",
    grepprg = "rg --hidden --vimgrep --smart-case --",
    breakat = [[\ \	;:,!?]],
    startofline = false,
    whichwrap = "h,l,<,>,[,],~",
    splitbelow = true,
    splitright = true,
    switchbuf = "useopen",
    backspace = "indent,eol,start",
    diffopt = "filler,iwhite,internal,algorithm:patience",
    completeopt = "menuone,noselect",
    jumpoptions = "stack",
    showmode = false,
    shortmess = "aoOTIcF",
    scrolloff = 8,
    sidescrolloff = 5,
    foldlevelstart = 99,
    cursorline = true,
    cursorcolumn = true,
    list = true,
    showtabline = 2,
    winwidth = 30,
    winminwidth = 10,
    helpheight = 12,
    previewheight = 12,
    showcmd = false,
    cmdheight = 1,
    cmdwinheight = 5,
    equalalways = false,
    laststatus = 2,
    display = "lastline",
    showbreak = "↳  ",
    listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←",
    pumheight = 15,
    pumwidth = 20,
    pumblend = 10,
    winblend = 10,
    autoread = true,
    autowrite = true,

    undofile = true,
    synmaxcol = 2500,
    formatoptions = "1jcroql",
    expandtab = true,
    autoindent = true,
    tabstop = 4,
    shiftwidth = 4,
    softtabstop = 4,
    breakindentopt = "shift:2,min:20",
    wrap = false,
    linebreak = true,
    number = true,
    relativenumber = true,
    foldenable = true,
    signcolumn = "yes",
    conceallevel = 0,
    concealcursor = "niv",
}

vim.g.mapleader = ","
vim.opt.smartindent = true

for name, value in pairs(global_local) do
    vim.o[name] = value
end

vim.cmd([[
syntax enable
filetype indent on
filetype plugin indent on
]])
