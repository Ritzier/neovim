local servers = {
    "sumneko_lua",
    "volar",
    "pyright",
    "html",
    "cssls",
    "flow",
    "graphql",
    "quick_lint_js",
    "svelte",
    "tailwindcss",
    "tsserver",
    "efmls-configs",
}

require("lsp-config.lsp").setup(servers)

require("lsp-config.handlers").setup()

require("lsp-config.mason").setup()
