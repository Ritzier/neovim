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

  use({
    "mrjones2014/legendary.nvim",
    opt =true,
    keys = {[[<C-p>]]},
    module = {"legendary"},
    cmd = {"Legendary"},
    config = function()
      require("configuration.legendary")
    end
  })

	-- Colorscheme
	use({ "pineapplegiant/spaceduck" })

	use({ "catppuccin/nvim", as = "catppuccin" })

	-- Performance
	use({ "lewis6991/impatient.nvim" })

	-- Load only when require
	use({ "nvim-lua/plenary.nvim", module = "plenary" })

	--AutoPairs
	use({
    "windwp/nvim-autopairs",
    config = function()
      require("configuration.autopairs")
    end
	})

  -- Term
  use({
    "akinsho/toggleterm.nvim",
    config = function()
      require("configuration.toggleterm")
    end
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

	-- NvimTree
	use({ "kyazdani42/nvim-web-devicons" })
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("configuration.nvim_tree")
		end,
	})

	-- Bufferline
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("configuration.bufferline")
		end,
	})

	-- TreeSitter
	use({
		"nvim-treesitter/nvim-treesitter",
		requires = {
			{ "windwp/nvim-ts-autotag" },
			{ "RRethy/nvim-treesitter-endwise" },
			{ "p00f/nvim-ts-rainbow" },
			{ "jiangmiao/auto-pairs" },
			{
				"lukas-reineke/indent-blankline.nvim",
				config = function()
					require("configuration.indentline")
				end,
			},
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
		},
		config = function()
			require("configuration.treesitter")
		end,
	})

	-- Lualine
	use({
		"nvim-lualine/lualine.nvim",
		requires = {
			{ "SmiteshP/nvim-navic" },
			{ "SmiteshP/nvim-gps" },
		},
		config = function()
			require("configuration.lualine")
		end,
	})

	--Comment
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("configuration.gitsigns")
		end,
	})

	-- Wilder
	use({
		"gelguy/wilder.nvim",
		config = function()
			require("configuration.wilder")
		end,
	})

	-- Dressing
	use({
		"stevearc/dressing.nvim",
		event = "BufReadPre",
		config = function()
			require("dressing").setup({
				input = { relative = "editor" },
				select = {
					backend = { "telescope", "fzf", "builtin" },
				},
			})
		end,
		disable = false,
	})

	-- Suda
	use({ "lambdalisue/suda.vim" })

	-- Neovim in browser
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

	-- FileType
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})
	use({ "Vimjas/vim-python-pep8-indent" })
	-- Rust
  use({
    "rust-lang/rust.vim",
    ft = "rust",
  })
	use({
		"simrat39/rust-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
		module = "rust-tools",
		ft = { "rust" },
	})
	use({
		"saecki/crates.nvim",
		event = { "BufRead Cargo.toml" },
		requires = { { "nvim-lua/plenary.nvim" } },
		config = function()
			-- local null_ls = require "null-ls"
			require("crates").setup({
				null_ls = {
					enabled = true,
					name = "crates.nvim",
				},
			})
		end,
	})

	-- Go
	use({
		"ray-x/go.nvim",
		ft = { "go" },
		config = function()
			require("go").setup()
		end,
	})

	-- Java
	use({ "mfussenegger/nvim-jdtls", ft = { "java" } })

	-- Flutter
	use({
		"akinsho/flutter-tools.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = function()
			require("configuration.flutter").setup()
		end,
	})

	-- Kotlin
	use({
		"udalov/kotlin-vim",
		ft = { "kotlin" },
		disable = true,
	})

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		wants = {
			"mason.nvim",
			"mason-lspconfig.nvim",
			"mason-tools-installer.nvim",
			"cmp-nvim-lsp",
			"lua-dev.nvim",
			"null-ls.nvim",
			"schemastore.nvim",
			"typescript.nvim",
			"nvim-navic",
			"inlay-hints.nvim",
		},
		requires = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"folke/lua-dev.nvim",
			"RRethy/vim-illuminate",
			"jose-elias-alvarez/null-ls.nvim",
			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup({})
				end,
			},
			"b0o/schemastore.nvim",
			"jose-elias-alvarez/typescript.nvim",
			{
				"SmiteshP/nvim-navic",
				config = function()
					require("nvim-navic").setup({})
				end,
				module = { "nvim-navic" },
			},
			{
				"simrat39/inlay-hints.nvim",
				config = function()
					require("inlay-hints").setup()
				end,
			},
			{
				"j-hui/fidget.nvim",
				config = function()
					require("fidget").setup()
				end,
			},
			{ "hrsh7th/nvim-cmp" },
			{ "lukas-reineke/cmp-under-comparator" },
			{ "kdheepak/cmp-latex-symbols" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-path" },
			{ "mrshmllow/document-color.nvim" },
			{ "L3MON4D3/LuaSnip" },
			{ "onsails/lspkind.nvim" },
      {
        "glepnir/lspsaga.nvim",
        cmd = { "Lspsaga" },
        config = function()
          require("configuration.lspsaga")
        end,
      },
      {
        "folke/trouble.nvim",
        cmd = { "TroubleToggle", "Trouble" },
        config = function()
          require("configuration.trouble")
        end,
      },
      {
        "tzachar/cmp-tabnine",
      }
		},
	})

	-- renamer.nvim
	use({
		"filipdutescu/renamer.nvim",
		module = { "renamer" },
		config = function()
			require("renamer").setup({})
		end,
	})

  -- WhichKey
  use({
    "folke/which-key.nvim",
    event = "VimEnter",
    config = function()
      require("configuration.whichkey").setup()
    end,
    disable = false
  })

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
