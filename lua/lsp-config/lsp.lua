local M = {}

local navic = require("nvim-navic")
local gps = require("nvim-gps")

local on_attach = require("lsp-config.servers.on_attach").on_attach
local capabilities = require("lsp-config.servers.capabilities").capabilities

local function set_server(name, attach, capabilitie)
    require("lsp-config.servers." .. name).setup(attach, capabilitie)
end

function M.setup(servers)
    for _, server in ipairs(servers) do

        if server == "sumneko_lua" then
            set_server("sumneko_lua", on_attach, capabilities)
            -- require("lsp-config.servers.test")

        elseif server == "gopls" then
            set_server("gopls", on_attach, capabilities)

        elseif server == "efmls-configs" then
            require("efmls-configs").init({
                on_attach = on_attach,
                capabilities = capabilities,
                init_options = { documentFormatting = true, codeAction = true },
            })

        elseif server == "omnisharp" then
            require("lspconfig")[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
                use_mono = true,
            })

        elseif server == "cssls" then
            set_server("cssls", on_attach, capabilities)

        elseif server == "html" then
            set_server("html", on_attach, capabilities)

        elseif server == "clangd" then
            set_server("clangd", on_attach, capabilities)

        else
            require("lspconfig")[server].setup({
                on_attach = on_attach,
                capabilities = capabilities,
            })
        end
    end
end

return M
