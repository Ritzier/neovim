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

require("lsp.mason").mason(servers)

require("lsp.lspconfig").setup(servers)

require("lsp.cmp")

require("lsp.lsp_signature")

require("lsp.codes")

require("lsp.lspsaga")
