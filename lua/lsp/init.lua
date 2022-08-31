local servers = {
	"angularls",
	"arduino_language_server",
	"bashls",
	"clangd",
	"cssls",
	"cmake",
	"dartls",
	"dotls",
	"gopls",
	"dockerls",
  "efm",
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
  "opencl_ls",
  "perlnavigator",
  "r_language_server",
  "solargraph",
  "vuels",
}

require("lsp.mason").mason(servers)

require("lsp.lspconfig").setup(servers)

require("lsp.cmp")

require("lsp.lsp_signature")

require("lsp.codes")

require("lsp.lspsaga")

require("which-key").register({
    l = {
        name = "LSP",
        v = {":DocsViewToggle<cr>", "Docs View"},
    },
    ls = { name = "Lsp Saga", },
    ll = {name="LSP"},
    llc = { name = "Code Action" },
    llD = { name = "Declaration" },
    llf = { name = "Formatting" },
    llh = {name="Hover"},
    lli = {name="Implementation"},
    lls = {name="Singature Help"},
    lln = {name="Rename"},
    llr = {name="References"},
    llt = {name="Type Definition"},
}, {prefix="<leader>"})
