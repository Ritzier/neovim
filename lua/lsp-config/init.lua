local servers = {
    "sumneko_lua",
    "volar",
    "pyright",
    "html",
    "cssls",
}

require("lsp-config.lsp").setup(servers)

require("lsp-config.handlers").setup()

require("lsp-config.mason").setup()
