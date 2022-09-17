local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attach = require("lsp-config.lsp").on_attach

require("lspconfig")["sumneko_lua"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})
