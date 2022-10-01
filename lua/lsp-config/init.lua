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
    "bashls",
    "rust_analyzer",
    "clangd",
    "omnisharp",
    "dartls",
    "cmake",
}

require("lsp-config.lsp").setup(servers)

require("lsp-config.handlers").setup()

require("lsp-config.mason").setup()

require("lsp-config.format").toggle_format_on_save()
