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

local config = function(path)
	require("configuration." .. path)
end

-- Install your plugins here
return packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "lewis6991/impatient.nvim" })
	use({ "nathom/filetype.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	use({ "kyazdani42/nvim-web-devicons" })
  use({ "nvim-lua/popup.nvim" })

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
		config = config("nvim_tree"),
	})

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		config = config("bufferline"),
	})

  -- Status Line
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      { "SmiteshP/nvim-navic" },
      { "SmiteshP/nvim-gps" },
    },
    config = config("lualine")
  })

	-- CommandLine
	use({
		"gelguy/wilder.nvim",
		config = config("wilder"),
	})

	-- Dressing
	use({
		"stevearc/dressing.nvim",
		event = "BufReadPre",
		-- config = config("dressing"),
		requires = { "MunifTanjim/nui.nvim" },
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
				config = config("indentline"),
			},
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{
				"m-demare/hlargs.nvim",
				config = function()
					require("hlargs").setup()
				end,
			},
		},
		config = config("treesitter"),
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
		config = config("gitsigns"),
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

	-- Show color
	use({
		"rktjmp/lush.nvim",
		cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
	})
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("configuration.colorizer")
		end,
	})

  -- LSP
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      {"hrsh7th/nvim-compe"},
      {"neovim/nvim-lspconfig"},
      {"williamboman/mason.nvim"},
      {"williamboman/mason-lspconfig.nvim"},
      {"WhoIsSethDaniel/mason-tool-installer.nvim"},
      {"L3MON4D3/LuaSnip"},
      {"hrsh7th/nvim-cmp"},
      {"hrsh7th/cmp-nvim-lua"},
      {"hrsh7th/cmp-nvim-lsp"},
      {"hrsh7th/cmp-buffer"},
      {"hrsh7th/cmp-path"},
      {"hrsh7th/cmp-calc"},
      {"tzachar/cmp-tabnine", run="./install.sh"},
      {"David-Kunz/cmp-npm"},
      {"saadparwaiz1/cmp_luasnip"},
      {"kdheepak/cmp-latex-symbols"},
      {"onsails/lspkind-nvim"},
      {"glepnir/lspsaga.nvim"},
      {"folke/lsp-trouble.nvim"},
      {"ray-x/lsp_signature.nvim"},
      {"folke/lua-dev.nvim"},
      {"j-hui/fidget.nvim",config=function() require("fidget").setup() end},
      {"b0o/schemastore.nvim"},
      {"jose-elias-alvarez/typescript.nvim"},
      {"rust-lang/rust.vim"},
      {"simrat39/rust-tools.nvim"},
      {
        "saecki/crates.nvim",
        event = {"BufRead Cargo.toml"},
        config = function()
          require("crates").setup({
            null_ls = {
              enabled = true,
              name = "crates.nvim"
            }
          })
        end
      },
      {"ray-x/go.nvim", config=function() require("go").setup() end},
      {"mfussenegger/nvim-jdtls"},
      {"akinsho/flutter-tools.nvim"},
      {"udalov/kotlin-vim"},
    }
  })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
