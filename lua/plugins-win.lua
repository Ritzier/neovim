local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  use({ "wbthomason/packer.nvim" })
  use({ "lewis6991/impatient.nvim" })
  use({ "nathom/filetype.nvim" })
  use({ "nvim-lua/plenary.nvim" })
  use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lua/popup.nvim" })
  use({ "RishabhRD/popfix" })
  use({ "hood/popui.nvim" })

  use({
    "mrjones2014/legendary.nvim",
    opt = true,
    keys = { [[<C-p>]] },
    module = { "legendary" },
    cmd = { "Legendary" },
    config = function()
      require("configuration.legendary")
    end,
  })

  -- Colorscheme
  use({ "EdenEast/nightfox.nvim" })
  use({ "pineapplegiant/spaceduck" })

  -- UI
  -- NvimTree
  use({
    "kyazdani42/nvim-tree.lua",
    config = function() require("configuration.nvim_tree") end,
  })

  -- Bufferline
  use({
    "akinsho/bufferline.nvim",
    config = function() require("configuration.bufferline") end,
  })

  -- Status Line
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      { "SmiteshP/nvim-navic" },
      { "SmiteshP/nvim-gps" },
    },
    config = function() require("configuration.lualine") end,
  })

  -- CommandLine
  use({
    "gelguy/wilder.nvim",
    config = function() require("configuration.wilder") end,
  })

  -- Dressing
  use({
    "stevearc/dressing.nvim",
    event = "BufReadPre",
    requires = {
      "MunifTanjim/nui.nvim",
    },
    config = function() require("configuration.dressing") end,
  })

  -- TreeSitter
  use({
    "nvim-treesitter/nvim-treesitter",
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects" },
      { "RRethy/nvim-treesitter-textsubjects" },
      { "windwp/nvim-ts-autotag" },
      { "RRethy/nvim-treesitter-endwise" },
      { "p00f/nvim-ts-rainbow" },
      { "jiangmiao/auto-pairs" },
      {
        "lukas-reineke/indent-blankline.nvim",
        config = function() require("configuration.indentline") end,
      },
      { "JoosepAlviste/nvim-ts-context-commentstring" },
      {
        "m-demare/hlargs.nvim",
        config = function()
          require("hlargs").setup()
        end,
      },
    },
    config = function() require("configuration.treesitter") end,
  })

  -- Tools
  -- Comment
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function() require("configuration.gitsigns") end,
  })
  use({ "kdheepak/lazygit.nvim" })

  -- Suda
  use({ "lambdalisue/suda.vim" })

  -- Nvim in browser
  use({
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  })

  use({
    "antoinemadec/FixCursorHold.nvim",
    event = "BufReadPre",
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  })

  -- Align
  use({
    "junegunn/vim-easy-align",
    cmd = "EasyAlign",
  })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "williamboman/nvim-lsp-installer" },
      { "neovim/nvim-lspconfig" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "hrsh7th/nvim-compe" },
      { "L3MON4D3/LuaSnip" },
      { "hrsh7th/cmp-nvim-lua" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/cmp-calc" },
      { "saadparwaiz1/cmp_luasnip" },
      { "kdheepak/cmp-latex-symbols" },
      {"creativenull/efmls-configs-nvim"},

      { "onsails/lspkind-nvim" },
      { "glepnir/lspsaga.nvim" },
      { "folke/lsp-trouble.nvim" },
      { "ray-x/lsp_signature.nvim" },
      { "j-hui/fidget.nvim", config = function() require("fidget").setup() end },
      { "lukas-reineke/cmp-under-comparator" },
      { "nvim-lua/lsp-status.nvim" },

      { "folke/lua-dev.nvim" },
      { "p00f/clangd_extensions.nvim" },
      { "simrat39/rust-tools.nvim" },
      {
        "saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = function()
          require("crates").setup({
            null_ls = {
              enabled = true,
              name = "crates.nvim"
            }
          })
        end
      },
      { "jose-elias-alvarez/typescript.nvim" },
      { "b0o/schemastore.nvim" },
    },
    config = function() require("lsp") end,
  })

  -- DAP
  use({
    "mfussenegger/nvim-dap",
    requires = {
      { "alpha2phi/DAPInstall.nvim" },
      { "rcarriga/nvim-dap-ui", config = function() require("dapui") end },
      {"theHamsta/nvim-dap-virtual-text"},
      {"jbyuki/one-small-step-for-vimkind"},
      { "leoluz/nvim-dap-go" },
    },
    cmd = { 'BreakpointToggle', 'Debug', 'DapREPL' },
    config = function() require("dap-config") end,
  })

  -- Toggleterm
  use({
    "akinsho/toggleterm.nvim",
    config = function() require("configuration.toggleterm") end,
  })

  -- FileType
  use({ "ray-x/go.nvim", config = function() require("go").setup() end })
  use({ "mfussenegger/nvim-jdtls" })
  use({ "akinsho/flutter-tools.nvim", config = function() require("flutter-tools").setup() end })
  use({ "udalov/kotlin-vim" })
  use({ "rust-lang/rust.vim" })
  use({ "Shatur/neovim-cmake", cmd = "CMake" })
  use({ "chrisbra/csv.vim" })

  -- WhichKey
  use({
    "folke/which-key.nvim",
  })

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
