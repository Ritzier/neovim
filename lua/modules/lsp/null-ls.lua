local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local with_diagnostics_code = function(builtin)
	return builtin.with({
		diagnostics_format = "#{m} [#{c}]",
	})
end

local code_actions = null_ls.builtins.code_actions

null_ls.setup({
    debug = true,
	sources = {
		formatting.prettierd,
		formatting.shfmt,
		formatting.shellharden,
		formatting.fixjson,
        formatting.black.with({ extra_args = { "--fast" } }),
        --formatting.autopep8,
		formatting.isort,
		formatting.stylua,
		formatting.google_java_format,
        formatting.djhtml,

		-- diagnostics
		diagnostics.write_good,
		diagnostics.eslint_d,
		diagnostics.flake8,
		diagnostics.tsc,

        with_diagnostics_code(diagnostics.shellcheck),
        diagnostics.zsh,

        -- Code Action
        code_actions.eslint_d,
        code_actions.gitrebase,
        code_actions.refactoring,
        code_actions.proselint,
        code_actions.shellcheck,
        code_actions.gitsigns,
	},
})
