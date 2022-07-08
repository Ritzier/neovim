local plugins = { "nvim-lsp-installer", "cmp", "luasnip", "lspconfig" }
for _, p in ipairs(plugins) do
    if not pcall(require, p) then
        print(p .. " not work")
        return
    end
end

local cmp = require("cmp")
cmp.setup({
    preselect = cmp.PreselectMode.Item,
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "crates" },
    },
})

local servers = { "sourcekit", "jsonls", "pyright", "sumneko_lua", "rust_analyzer", "jdtls", "tsserver" }

local lspconfig = require("lspconfig")
local schemas, _ = pcall(require, "schemastore")

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
    if client.resolved_capabilities.document_formatting then
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
    end
end

local opts = {
    -- on_attach = require("modules.lsp.handlers").on_attach,
    on_attach = on_attach,
    capabilities = require("modules.lsp.handlers").capabilities,
}

for _, server in pairs(servers) do
    local has_custom_opts, server_custom_opts = pcall(require, "modules.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

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
        local extension_path = vim.fn.stdpath("config") .. "vadimcn.vscode-lldb-1.7.0/"
        local codelldb_path = extension_path .. "adapter/codelldb"
        local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
        require("rust-tools").setup({
            server = opts,
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
        })
    elseif server == "tsserver" then
        on_attach = function(client, bufnr)
            client.resolved_capabilities.document_formatting = false
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
