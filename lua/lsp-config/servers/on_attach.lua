local M = {}

local navic = require("nvim-navic")
local gps = require("nvim-gps")
local keymap = vim.keymap.set

function M.on_attach(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	local opts = { noremap = true, silent = true }

	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")

	keymap("n", "K", vim.lsp.buf.hover, bufopts)
	keymap("n", "<space>e", vim.diagnostic.open_float, bufopts)
	keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
	keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
	keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", bufopts)
	keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", bufopts)

	keymap("n", "<space>ln", "<cmd>Lspsaga rename<CR>", bufopts)
	keymap("n", "<space>lf", "<cmd>L")

	require("lsp-config.highlighter").setup(client, bufnr)

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
		-- handler_opts = { "double" },
	})

	if client.name ~= "tailwindcss"
		and client.name ~= "bashls"
		and client.name ~= "html"
		and client.name ~= "angularls"
		and client.name ~= "efm"
		and client.name ~= "cssls"
		and client.nmae ~= "cmake"
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

	require("lsp-format").on_attach(client)
end

return M
