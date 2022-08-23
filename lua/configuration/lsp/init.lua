local servers = {
	"angularls",
	"arduino_language_server",
	"bashls",
	"clangd",
	"cssls",
	"clangd",
	"cmake",
	"dartls",
	"dotls",
	"gopls",
	"dockerls",
"html",
    "jdtls",
	"jsonls",
	"julials",
	"pyright",
	"rust_analyzer",
	"kotlin_language_server",
	"sumneko_lua",
	"tailwindcss",
	"tsserver",
	"omnisharp",
}

require("configuration.lsp.mason").mason(servers)

require("configuration.lsp.config").setup(servers)

require("configuration.lsp.cmp")

require("configuration.lsp.null-ls")
