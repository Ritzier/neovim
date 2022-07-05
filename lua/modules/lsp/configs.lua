local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local servers = { "sourcekit", "jsonls", "pyright", "sumneko_lua", "rust_analyzer", "jdtls", "tsserver" }

local lspconfig = require("lspconfig")
local schemas, _ = pcall(require, "schemastore")


lsp_installer.setup({
    ensure_installed = servers,
})

local opts = {
    on_attach = require("modules.lsp.handlers").on_attach,
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
                adapter = require("rust-tools.dap").get_codelldb_adapter(
                    codelldb_path, liblldb_path
                )
            }
        })
    elseif server == "tsserver" then
        require("typescript").setup({
            disable_commands = false,
            debug = false,
            server = opts,
        })
    elseif server == "jdtls" then
        local present, _ = pcall(require, "jdtls")
        if present then
            require("nvim-jdtls").setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
            vim.lsp.codelens.refresh()
        else
            lspconfig[server].setup(opts)
        end
    else
        lspconfig[server].setup(opts)
    end
end
