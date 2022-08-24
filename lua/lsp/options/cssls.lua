local M = {}

function M.attach(client, bufnr)
	local navic = require("nvim-navic")
	local gps = require("nvim-gps")
	if
		client.name ~= "tailwindcss"
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
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require("cmp_nvim_lsp").update_capabilities(M.capabilities)
M.capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

return M
