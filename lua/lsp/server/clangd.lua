local capabilities = require("lsp.server.default").capabilities
capabilities.offsetEncoding = { "utf-16" }

local attach = require("lsp.server.default").on_attach

local commands = [[
if !exists(':ClangdAST')
  function s:memuse_compl(_a,_b,_c)
      return ['expand_preamble']
  endfunction
  command ClangdSetInlayHints lua require('clangd_extensions.inlay_hints').set_inlay_hints()
  command ClangdDisableInlayHints lua require('clangd_extensions.inlay_hints').disable_inlay_hints()
  command ClangdToggleInlayHints lua require('clangd_extensions.inlay_hints').toggle_inlay_hints()
  command -range ClangdAST lua require('clangd_extensions.ast').display_ast(<line1>, <line2>)
  command ClangdTypeHierarchy lua require('clangd_extensions.type_hierarchy').show_hierarchy()
  command ClangdSymbolInfo lua require('clangd_extensions.symbol_info').show_symbol_info()
  command -nargs=? -complete=customlist,s:memuse_compl ClangdMemoryUsage lua require('clangd_extensions.memory_usage').show_memory_usage('<args>' == 'expand_preamble')
endif
]]

require("clangd_extensions").setup({
	server = {
		capabilities = capabilities,
		on_attach = attach,
		single_file = true,
		args = {
			"--background-index",
			"--pch-storage=memory",
			"--clang-tidy",
			"--suggest-missing-includes",
      "--all-scopes-completion",
      "--pch-storage=memory",
      "--log=info",
      "--enable-config",
      "--completion-style=detailed",
      "--offset-encoding=utf-16",
		},
	},
	extensions = {
		autoSetHints = true,
		inlay_hints = {
			only_current_line = false,
			only_current_line_autocmd = "CursorHold",
			show_parameter_hints = true,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
			priority = 100,
		},
  },
})
