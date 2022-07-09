local plugins = { "nvim-lsp-installer", "cmp", "luasnip", "lspconfig", "nvim-navic" }
for _, p in ipairs(plugins) do
    if not pcall(require, p) then
        print(p .. " not work")
        return
    end
end

local luasnip = require("luasnip")

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end


local function nvim_cmp()
    local cmp = require("cmp")

    cmp.setup({
        preselect = cmp.PreselectMode.Item,
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
            -- documentation = {
            --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
            -- },
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                local kind_icons = {
                    Text = "",
                    Method = "m",
                    Function = "",
                    Constructor = "",
                    Field = "",
                    Variable = "",
                    Class = "",
                    Interface = "",
                    Module = "",
                    Property = "",
                    Unit = "",
                    Value = "",
                    Enum = "",
                    Keyword = "",
                    Snippet = "",
                    Color = "",
                    File = "",
                    Reference = "",
                    Folder = "",
                    EnumMember = "",
                    Constant = "",
                    Struct = "",
                    Event = "",
                    Operator = "",
                    TypeParameter = "",
                }

                -- local meta_type = vim_item.kind
                -- -- load lspkind icons
                -- vim_item.kind = lspkind_icons[vim_item.kind] .. ""
                -- vim_item.menu = ({
                --     buffer = " Buffer",
                --     nvim_lsp = meta_type,
                --     path = " Path",
                --     luasnip = " LuaSnip",
                -- })[entry.source.name]
                -- return vim_item

                vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    luasnip = "[Snippet]",
                    buffer = "[Buffer]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item

            end,
        },
        -- You can set mappings if you want
        mapping = cmp.mapping.preset.insert({
            -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-p>"] = cmp.mapping.select_prev_item(),
            ["<C-n>"] = cmp.mapping.select_next_item(),
            ["<C-d>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-c>"] = cmp.mapping.close(),
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            ["<C-e>"] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            --["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
        }),
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
    })
    vim.cmd("hi CmpFloatBorder guifg=red")
end

local function lua_snip()
    local ls = require("luasnip")
    ls.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
    })
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load({
        path = { "./snippets/" },
    })
end

local servers = { "sourcekit", "jsonls", "pyright", "sumneko_lua", "rust_analyzer", "jdtls", "tsserver", "bashls", "gopls", "julials" }

local lspconfig = require("lspconfig")
local schemas, _ = pcall(require, "schemastore")
local navic = require("nvim-navic")

require("nvim-lsp-installer").setup({
    ensure_installed = servers,
})

local buf_map = function(bufnr, mode, lhs, rhs, opts)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
        silent = true,
    })
end
local on_attach = function(client, bufnr)
    vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
    vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
    vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
    vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
    vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
    vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
    vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
    vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
    vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
    vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
    vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
    buf_map(bufnr, "n", "gd", ":LspDef<CR>")
    buf_map(bufnr, "n", "gr", ":LspRename<CR>")
    buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
    buf_map(bufnr, "n", "K", ":LspHover<CR>")
    buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
    buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
    buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
    buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
    buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
    if client.server_capabilities.documentFormattingProvider then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
    navic.attach(client, bufnr)
end

local opts = {
    -- on_attach = require("modules.lsp.handlers").on_attach,
    on_attach = on_attach,
    capabilities = require("modules.lsp.handlers").capabilities,
}

local signs = {
    Error = " ",
    Warn = " ",
    Info = " ",
    Hint = "ﴞ ",
}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = {
        source = true,
    },
})

for _, server in pairs(servers) do
    -- local has_custom_opts, server_custom_opts = pcall(require, "modules.lsp.settings." .. server)
    -- if has_custom_opts then
    --     opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    -- end

    if server == "jsonls" then
        if schemas then
            lspconfig[server].setup({
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                    },
                },
                opts,
            })
        else
            lspconfig[server].setup(opts)
        end
    elseif server == "sumneko_lua" then
        lspconfig[server].setup({
            settings = {
                Lua = {
                    runtime = {
                        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                        version = "LuaJIT",
                        -- Setup your lua path
                        path = vim.split(package.path, ";"),
                    },
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim", "describe", "it", "before_each", "after_each", "packer_plugins" },
                        -- disable = { "lowercase-global", "undefined-global", "unused-local", "unused-vararg", "trailing-space" },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        },
                        -- library = vim.api.nvim_get_runtime_file("", true),
                        maxPreload = 2000,
                        preloadFileSize = 50000,
                    },
                    completion = { callSnippet = "Both" },
                    telemetry = { enable = false },
                },
            },
            opts,
        })
    elseif server == "rust_analyzer" then
        lspconfig[server].setup({
            settings = {
                ["rust-analyzer"] = {
                    assist = {
                        importGranularity = "module",
                        importPrefix = "self",
                    },
                    cargo = {
                        loadOutDirsFromCheck = true,
                    },
                    procMacro = {
                        enable = true,
                    },
                },
            },
            opts,
        })
    elseif server == "tsserver" then
        on_attach = function(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.resolved_capabilities.document_range_formatting = false
            local ts_utils = require("nvim-lsp-ts-utils")
            ts_utils.setup({})
            ts_utils.setup_client(client)

            buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
            buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
            buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

            on_attach(client, bufnr)
        end
    elseif server == "jdtls" then
        local present, _ = pcall(require, "jdtls")
        if present then
            require("nvim-jdtls").setup_dap({ hotcodereplace = "auto" })
            require("jdtls.dap").setup_dap_main_class_configs()
            vim.lsp.codelens.refresh()
        else
            lspconfig[server].setup(opts)
        end
    else
        lspconfig[server].setup(opts)
    end
end

nvim_cmp()
-- lua_snip()
