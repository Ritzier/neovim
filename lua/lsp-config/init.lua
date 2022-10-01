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
    -- "efmls-configs",
    "efm",
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

-- require("lsp-config.format").toggle_format_on_save()

vim.api.nvim_create_autocmd("CursorHold", {
	buffer = bufnr,
	callback = function()
		local opt = {
			focusable = false,
			close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
			border = 'rounded',
			source = 'always',
			prefix = ' ',
			scope = 'cursor',
		}
		vim.diagnostic.open_float(nil, opt)
	end
})

