local M = {}
function M.mason(servers)
	local lspconfig = require("lspconfig")
	require("mason").setup({
		ui = {
			icons = {
				check_outdated_packages_on_open = true,
				border = "none",
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	})

	require("mason-tool-installer").setup({
    ensure_installed = {
      "codelldb",
      "stylua",
      "shfmt",
      "shellcheck",
      "prettierd",
      "cpplint",
      "hadolint",
      "goimports",
      "xo",
      "flake8",
      "black",
      "vint",
      "rubocop",
    },
		auto_update = true,
		run_on_start = true,
	})
end

return M
