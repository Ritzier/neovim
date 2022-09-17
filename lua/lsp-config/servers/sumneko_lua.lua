local M = {}

function M.setup(on_attach, capabilities)
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    require("lua-dev").setup({
        library = {
            enabled = true,
            runtime = true,
            types = true,
            plugins = true,
        },
        setup_jsonls = true,
    })

    require("lspconfig")["sumneko_lua"].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                runtime = {
                    version = 'LuaJIT',
                    path = runtime_path,
                },
                diagnostics = { globals = { "vim", "packer_plugins" } },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                    },
                    maxPreload = 100000,
                    preloadFileSize = 10000,
                },
                telemetry = { enable = false },
            },
        },
    })
end

return M
