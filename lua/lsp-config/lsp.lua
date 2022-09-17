local M = {}

local navic = require("nvim-navic")
local gps = require("nvim-gps")

function M.on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    local keymap = vim.keymap.set
    require("lsp-config.highlighter").setup(client, bufnr)
    require("lsp-config.keymaps").setup(client, bufnr)

    local opts = { noremap = true, silent = true }
    keymap("n", "<space>x", vim.lsp.buf.rename, opts)


    if client.server_capabilities.definitionProvider then
        vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
    end

    -- sqls
    if client.name == "sqls" then
        require("sqls").on_attach(client, bufnr)
    end

    require("lsp_signature").on_attach({
        bind = true,
        use_lspsaga = false,
        floating_window = true,
        fix_pos = true,
        hint_enable = true,
        hi_parameter = "Search",
        handler_opts = { "double" },
    })

    if client.name ~= "tailwindcss"
        and client.name ~= "bashls"
        and client.name ~= "html"
        and client.name ~= "angularls"
        and client.name ~= "efm"
        and client.name ~= "cssls"
    then
        navic.attach(client, bufnr)
        require("lualine").setup({
            sections = {
                lualine_c = {
                    { navic.get_location, cond = navic.is_available },
                },
            },
        })
    else
        require("lualine").setup({
            sections = {
                lualine_c = {
                    { gps.get_location, cond = gps.is_available },
                },
            },
        })
    end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
}
M.capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities) -- for nvim-cmp

local function set_server(name, on_attach, capabilitie)
    require("lsp-config.servers." .. name).setup(on_attach, capabilitie)
end

function M.setup(servers)
    for _, server in ipairs(servers) do

        if server == "sumneko_lua" then
            set_server("sumneko_lua", M.on_attach, M.capabilities)
            -- require("lsp-config.servers.test")

        elseif server == "gopls" then
            set_server("gopls", M.on_attach, M.capabilities)

        elseif server == "efmls-configs" then
            require("efmls-configs").init({
                on_attach = M.on_attach,
                capabilities = M.capabilities,
                init_options = { documentFormatting = true, codeAction = true },
            })

        elseif server == "omnisharp" then
            require("lspconfig")[server].setup({
                on_attach = M.on_attach,
                capabilities = M.capabilities,
                use_mono = true,
            })

        elseif server == "cssls" then
            set_server("cssls", M.on_attach, M.capabilities)

        elseif server == "html" then
            set_server("html", M.on_attach, M.capabilities)

        else
            require("lspconfig")[server].setup({
                on_attach = M.on_attach,
                capabilities = M.capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            })
        end
    end
end

return M
