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
    -- My plugins here

    use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
    use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
    use({ "windwp/nvim-autopairs" }) -- Autopairs, integrates with both cmp and treesitter
    use({ "numToStr/Comment.nvim" })
    use({ "JoosepAlviste/nvim-ts-context-commentstring" })
    use({ "kyazdani42/nvim-web-devicons" })
    use({ "kyazdani42/nvim-tree.lua" })
    use({ "akinsho/bufferline.nvim" })
    use({ "moll/vim-bbye" })
    use({ "nvim-lualine/lualine.nvim", after = "nvim-gps" })
    use({ "akinsho/toggleterm.nvim" })
    use({ "ahmedkhalf/project.nvim" })
    use({ "lewis6991/impatient.nvim" })
    use({ "lukas-reineke/indent-blankline.nvim" })
    use({ "goolord/alpha-nvim" })
    use("folke/which-key.nvim")
    use({ "nathom/filetype.nvim" })
    use({ "mrjones2014/legendary.nvim" })

    -- Colorschemes
    use("EdenEast/nightfox.nvim")

    -- cmp plugins
    use({ "hrsh7th/nvim-cmp" }) -- The completion plugin
    use({ "hrsh7th/cmp-buffer" }) -- buffer completions
    use({ "hrsh7th/cmp-path" }) -- path completions
    use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "hrsh7th/cmp-nvim-lua" })

    -- snippets
    use({ "L3MON4D3/LuaSnip" }) --snippet engine
    use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

    -- LSP
    use({ "neovim/nvim-lspconfig" }) -- enable LSP
    use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
    use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
    use({
        "glepnir/lspsaga.nvim",
        config = function()
            require("lspsaga").init_lsp_saga()
        end,
    })
    -- Other plugins
    use({ "folke/lua-dev.nvim" })
    use({ "RRethy/vim-illuminate" })
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget")
        end,
    })
    use({
        "jose-elias-alvarez/typescript.nvim",
    })
    use({
        "SmiteshP/nvim-navic",
        config = function()
            require("nvim-navic").setup()
        end,
    })
    use({"tpope/vim-dadbod"})

    -- Trouble
    use({
        "folke/trouble.nvim",
        opt = true,
        cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
    })

    -- GPS
    use({
        "SmiteshP/nvim-gps",
        after = "nvim-treesitter",
    })

    -- Align
    use({
        "junegunn/vim-easy-align",
        opt = true,
        cmd = "EasyAlign",
    })

    -- Sniprun
    use({
        "michaelb/sniprun",
        opt = true,
        run = "bash ./install.sh",
        cmd = { "SnipRun", "'<,'>SnipRun" },
    })

    -- Make command line better
    use({
        "gelguy/wilder.nvim",
        event = "CmdlineEnter",
        requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
    })

    -- Telescope
    use({ "nvim-telescope/telescope.nvim" })

    -- Treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
    })
    use({
        "windwp/nvim-ts-autotag",
        wants = "nvim-treesitter",
        event = "InsertEnter",
    })
    use({
        "RRethy/nvim-treesitter-endwise",
        after = "nvim-treesitter",
    })
    use({
        "p00f/nvim-ts-rainbow",
        after = "nvim-treesitter",
    })

    -- Git
    use({ "lewis6991/gitsigns.nvim" })

    -- Show color
    use({
        "norcalli/nvim-colorizer.lua",
        cmd = "ColorizerToggle",
        config = function()
            require("colorizer").setup()
        end,
    })
    use({
        "rktjmp/lush.nvim",
        cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
        disable = false,
    })

    -- language
    -- Json
    use({
        "b0o/SchemaStore.nvim",
    })

    -- web
    use({
        "vuki656/package-info.nvim",
        opt = true,
        requires = {
            "MunifTanjim/nui.nvim",
        },
        wants = { "nui.nvim" },
        module = { "package-info" },
        ft = { "json" },
        config = function()
            require("config.package").setup()
        end,
        disable = false,
    })

    -- Kotlin
    use({ "udalov/kotlin-vim", ft = { "kotlin" }, disable = true })

    -- Flutter
    use({
        "akinsho/flutter-tools.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        disable = true,
    })

    -- Go
    use({
        "ray-x/go.nvim",
        ft = { "go" },
        config = function()
            require("go").setup()
        end,
    })

    -- Rust
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
    })

    -- Typescript
    use({
        "jose-elias-alvarez/nvim-lsp-ts-utils",
    })

    -- Java
    use({
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
    })

    -- Usefull plugins
    use({
        "m-demare/attempt.nvim",
        requires = "nvim-lua/plenary.nvim",
        module = { "attempt" },
    })

    -- REPL
    use({
        "hkupty/iron.nvim",
    })

    -- View and search LSP symbols
    use({
        "liuchengxu/vista.vim",
        cmd = { "Vista" },
        config = function()
            vim.g.vista_default_executive = "nvim_lsp"
        end,
    })

    -- Diffview
    use({
        "sindrets/diffview.nvim",
        requires = "nvim-lua/plenary.nvim",
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    })

    -- Plugin
    use({
        "tpope/vim-scriptease",
        cmd = {
            "Messages", --view messages in quickfix list
            "Verbose", -- view verbose output in preview window.
            "Time", -- measure how long it takes to run some stuff.
        },
        event = "BufReadPre",
    })
    use({
        "dstein64/vim-startuptime"
    })

    -- Symbols outline
    use({ "simrat39/symbols-outline.nvim" })

    -- Quickfix
    use({ "romainl/vim-qf", event = "BufReadPre", disable = true })

    -- Refactoring
    use({

        "ThePrimeagen/refactoring.nvim",
        module = { "refactoring", "telescope" },
        keys = { [[<leader>r]] },
        wants = { "telescope.nvim" },
    })

    -- Test
    use({
        "nvim-neotest/neotest",
        wants = {
            "plenary.nvim",
            "nvim-treesitter",
            "FixCursorHold.nvim",
            "neotest-python",
            "neotest-plenary",
            "neotest-go",
            "neotest-jest",
            "neotest-vim-test",
        },
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-neotest/neotest-python",
            "nvim-neotest/neotest-plenary",
            "nvim-neotest/neotest-go",
            "haydenmeade/neotest-jest",
            "nvim-neotest/neotest-vim-test",
        },
        module = { "neotest" },
    })

    -- Debug
    use({
        "mfussenegger/nvim-dap",
        keys = { [[<leader>d]] },
        module = { "dap" },
    })
    use({ "alpha2phi/DAPInstall.nvim" })
    use({ "theHamsta/nvim-dap-virtual-text" })
    use({"rcarriga/nvim-dap-ui"})
    use({ "mfussenegger/nvim-dap-python" })
    use({ "nvim-telescope/telescope-dap.nvim" })
    use({ "leoluz/nvim-dap-go", module = "dap-go" })
    use({ "jbyuki/one-small-step-for-vimkind", module = "osv" })

    -- Open neovim in browser
    use({
        "glacambre/firenvim",
        run = function()
            vim.fn["firenvim#install"](0)
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
