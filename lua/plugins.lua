local M = {}

function M.setup()
    -- Indicate first time installation
    local packer_bootstrap = false

    -- packer.nvim configuration
    local conf = {
        profile = {
            enable = true,
            threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
        },

        display = {
            open_fn = function()
                return require("packer.util").float({ border = "rounded" })
            end,
        },
    }

    -- Check if packer.nvim is installed
    -- Run PackerCompile if there are changes in this file
    local function packer_init()
        local fn = vim.fn
        local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
        if fn.empty(fn.glob(install_path)) > 0 then
            packer_bootstrap = fn.system({
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            })
            vim.cmd([[packadd packer.nvim]])
        end

        -- Run PackerCompile if there are changes in this file
        -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
        local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
        vim.api.nvim_create_autocmd(
            { "BufWritePost" },
            { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packer_grp }
        )
    end

    -- Plugins
    local function plugins(use)
        use({ "wbthomason/packer.nvim" })
        use({ "lewis6991/impatient.nvim" })
        use({ "nvim-lua/plenary.nvim" })
        use({ "kyazdani42/nvim-web-devicons" })

        -- Legendary
        use({
            "mrjones2014/legendary.nvim",
            opt = true,
            keys = { [[<C-p>]] },
            -- wants = { "dressing.nvim" },
            module = { "legendary" },
            cmd = { "Legendary" },
            config = function()
                require("configuration.legendary")
            end,
            -- requires = { "stevearc/dressing.nvim" },
        })

        -- Colorscheme
        use({ "EdenEast/nightfox.nvim" })
        use({ "pineapplegiant/spaceduck" })

        -- UI
        use({
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("configuration.nvim_tree")
            end,
        })
        use({
            "akinsho/bufferline.nvim",
            config = function()
                require("configuration.bufferline")
            end,
        })
        use({
            "SmiteshP/nvim-navic",
            config = function()
                require("configuration.navic")
            end,
        })
        use({
            "SmiteshP/nvim-gps",
            config = function()
                require("configuration.gps")
            end,
        })
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
        use({
            "nvim-treesitter/nvim-treesitter",
            requires = {
                { "nvim-treesitter/nvim-treesitter-textobjects" },
                { "RRethy/nvim-treesitter-textsubjects" },
                { "windwp/nvim-ts-autotag" },
                { "RRethy/nvim-treesitter-endwise" },
                { "p00f/nvim-ts-rainbow" },
                {
                    "lukas-reineke/indent-blankline.nvim",
                },
                { "JoosepAlviste/nvim-ts-context-commentstring" },
            },
            config = function()
                require("configuration.treesitter")
            end,
        })
        use({
            "gelguy/wilder.nvim",
            config = function()
                require("configuration.wilder")
            end,
        })
        -- use({
        --     "goolord/alpha-nvim",
        --     after = "bufferline.nvim",
        --     config = function()
        --         require("configuration.alpha")
        --     end,
        -- })

        -- Tools
        -- use({
        --     "alvan/vim-closetag",
        --     config = function() require("configuration.closetag") end,
        -- })
        use({
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end,
        })
        use({
            "lewis6991/gitsigns.nvim",
            requires = { "nvim-lua/plenary.nvim" },
            config = function()
                require("configuration.gitsigns")
            end,
        })
        use({ "kdheepak/lazygit.nvim" })
        -- Suda
        use({ "lambdalisue/suda.vim" })
        -- Toggleterm
        use({
            "akinsho/toggleterm.nvim",
            config = function()
                require("configuration.toggleterm")
            end,
        })
        -- WhichKey
        use({
            "folke/which-key.nvim",
            config = function() require("configuration.which_key") end
        })
        -- Better surround
        use({ "tpope/vim-surround", event = "BufReadPre" })
        use({
            "Matt-A-Bennett/vim-surround-funk",
            after = "which-key",
            event = "BufReadPre",
            config = function()
                require("config.surroundfunk").setup()
            end,
            disable = true,
        })

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

        -- Doc
        use({ "nanotee/luv-vimdocs", event = "BufReadPre" })
        use({ "milisims/nvim-luaref", event = "BufReadPre" })

        -- Better Netrw
        use({ "tpope/vim-vinegar", event = "BufReadPre" })

        -- Todo
        use({
            "folke/todo-comments.nvim",
            config = function()
                require("configuration.todo-comments")
            end,
            cmd = { "TodoQuickfix", "TodoTrouble", "TodoTelescope" },
        })

        use({
            "pwntester/octo.nvim",
            cmd = "Octo",
            wants = { "telescope.nvim", "plenary.nvim", "nvim-web-devicons" },
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-telescope/telescope.nvim",
                "kyazdani42/nvim-web-devicons",
            },
            config = function()
                require("octo").setup()
            end,
            disable = false,
        })

        -- User interface
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
        use({
            "ray-x/guihua.lua",
            run = "cd lua/fzy && make",
            disable = true,
        })
        use({
            "doums/suit.nvim",
            config = function()
                require("suit").setup({})
            end,
            disable = true,
        })

        -- DB
        use({
            "tpope/vim-dadbod",
            requires = {
                "kristijanhusak/vim-dadbod-ui",
                "kristijanhusak/vim-dadbod-completion",
                {
                    "nanotee/sqls.nvim",
                    module = { "sqls" },
                    cmd = {
                        "SqlsExecuteQuery",
                        "SqlsExecuteQueryVertical",
                        "SqlsShowDatabases",
                        "SqlsShowSchemas",
                        "SqlsShowConnections",
                        "SqlsSwitchDatabase",
                        "SqlsSwitchConnection",
                    },
                    {
                        "dinhhuy258/vim-database",
                        run = ":UpdateRemotePlugins",
                        cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
                    },
                },
            },
        })

        -- CMP
        use({
            "hrsh7th/nvim-cmp",
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    config = function()
                        require("cmp-config.luasnip")
                    end,
                    requires = "rafamadriz/friendly-snippets",
                },
                { "lukas-reineke/cmp-under-comparator" },
                { "saadparwaiz1/cmp_luasnip" },
                { "hrsh7th/cmp-nvim-lsp" },
                { "hrsh7th/cmp-nvim-lua" },
                { "andersevenrud/cmp-tmux" },
                { "hrsh7th/cmp-path" },
                { "f3fora/cmp-spell" },
                { "hrsh7th/cmp-buffer" },
                { "kdheepak/cmp-latex-symbols" },
                { "windwp/nvim-autopairs", config = function() require("cmp-config.autopairs") end },
            },
            config = function() require("cmp-config") end
        })

        -- LSP
        use({
            "neovim/nvim-lspconfig",
            after = "nvim-cmp",
            requires = {
                { "williamboman/mason.nvim" },
                { "WhoIsSethDaniel/mason-tool-installer.nvim" },
                { "ray-x/lsp_signature.nvim" },
                {
                    "j-hui/fidget.nvim",
                    config = function()
                        require("fidget").setup()
                    end
                },
                {
                    "creativenull/efmls-configs-nvim",
                    config = function()
                        require("lsp-config.efm")
                    end,
                },
                {
                    "glepnir/lspsaga.nvim",
                    config = function()
                        require("lsp-config.lspsaga")
                    end,
                },

                { "folke/lua-dev.nvim" },
                { "p00f/clangd_extensions.nvim" },
                {
                    "simrat39/rust-tools.nvim",
                    requires = { "nvim-lua/plenary.nvim", "rust-lang/rust.vim" },
                },
                {
                    "saecki/crates.nvim",
                    event = { "BufRead Cargo.toml" },
                    config = function()
                        require("crates").setup({
                            null_ls = {
                                enabled = true,
                                name = "crates.nvim",
                            },
                        })
                    end,
                },
                { "jose-elias-alvarez/typescript.nvim" },
                { "b0o/schemastore.nvim" },
                { "akinsho/flutter-tools.nvim" },

                { "mfussenegger/nvim-jdtls", ft = { "java" } },
                {
                    "akinsho/flutter-tools.nvim",
                    requires = { "nvim-lua/plenary.nvim" },
                    config = function()
                        require("config.flutter").setup()
                    end,
                    disable = true,
                },
                { "udalov/kotlin-vim", ft = { "kotlin" }, disable = true },
                { "yuezk/vim-js" },
                { "HerringtonDarkholme/yats.vim" },
                { "maxmellon/vim-jsx-pretty" },
            },
            config = function() require("lsp-config") end,
        })

        -- Auotpairs
        -- use({
        --     "jiangmiao/auto-pairs",
        --     config = function()
        --         require("configuration.autopairs")
        --     end,
        -- })

        -- Colors
        -- use({
        --     "norcalli/nvim-colorizer.lua",
        --     cmd = "ColorizerToggle",
        --     config = function()
        --         require("colorizer").setup({
        --             '*';
        --         })
        --     end,
        -- })
        use({
            "brenoprata10/nvim-highlight-colors",
            config = function()
                require("nvim-highlight-colors").setup({
                    render = "background",
                    enable_tailwind = true
                })
                require("nvim-highlight-colors").turnOn()
            end,
        })
        use({
            "rktjmp/lush.nvim",
            cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
            disable = false,
        })
        use({
            "max397574/colortils.nvim",
            cmd = "Colortils",
            config = function()
                require("configuration.colortils")
            end,
        })
        use({
            "ziontee113/color-picker.nvim",
            cmd = { "PickColor", "PickColorInsert" },
            config = function()
                require("color-picker")
            end,
        })
        use({
            "lifepillar/vim-colortemplate",
            disable = true,
        })

        use({
            "nvim-telescope/telescope.nvim",
            config = function()
                require("telescope-config")
            end,
            requires = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-lua/popup.nvim" },
                { "jvgrootveld/telescope-zoxide" },
                { "nvim-telescope/telescope-project.nvim" },
                { "nvim-telescope/telescope-file-browser.nvim" },
                { "nvim-telescope/telescope-dap.nvim" },
                { 'nvim-telescope/telescope-fzf-native.nvim',
                    requires = { "tami5/sqlite.lua" },
                    run = "make",
                },
            },
        })

        -- FileType

        -- Go
        use({
            "ray-x/go.nvim",
            ft = { "go" },
            config = function()
                require("go").setup()
            end,
            disable = false,
        })

        -- Debugging
        use({
            "mfussenegger/nvim-dap",
            opt = true,
            -- event = "BufReadPre",
            keys = { [[<leader>d]] },
            module = { "dap" },
            wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
            requires = {
                -- "alpha2phi/DAPInstall.nvim",
                -- { "Pocco81/dap-buddy.nvim", branch = "dev" },
                "theHamsta/nvim-dap-virtual-text",
                "rcarriga/nvim-dap-ui",
                "mfussenegger/nvim-dap-python",
                "nvim-telescope/telescope-dap.nvim",
                { "leoluz/nvim-dap-go", module = "dap-go" },
                { "jbyuki/one-small-step-for-vimkind", module = "osv" },
            },
            config = function()
                require("dap-config").setup()
            end,
            disable = false,
        })

        use({
            "stevearc/aerial.nvim",
            config = function()
                require("aerial").setup()
            end,
            module = { "aerial" },
            cmd = { "AerialToggle" },
        })

        if packer_bootstrap then
            print("Neovim restart is required after installation!")
            require("packer").sync()
        end
    end

    -- Init and start packer
    packer_init()
    local packer = require("packer")

    -- Performance
    pcall(require, "impatient")
    -- pcall(require, "packer_compiled")

    packer.init(conf)
    packer.startup(plugins)
end

M.setup()
