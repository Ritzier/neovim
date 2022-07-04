local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

local lspconfig = require("lspconfig")
local servers = { "sourcekit", "jsonls", "pyright", "sumneko_lua", "rust_analyzer" }

lsp_installer.setup({
    ensure_installed = servers,
})

for _, server in pairs(servers) do
    local opts = {
        on_attach = require("modules.lsp.handlers").on_attach,
        capabilities = require("modules.lsp.handlers").capabilities,
    }
    local has_custom_opts, server_custom_opts = pcall(require, "modules.lsp.settings." .. server)
    if has_custom_opts then
        opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
    end

    local schemas, _ = pcall(require, "schemastore")

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
    else
        lspconfig[server].setup(opts)
    end
end
