--vim.cmd([[highlight indicator_selected guibg=#909090 guifg=#909090]])

return function()
	require("catppuccin").setup({
		flavour = "mocha",
		background = {
			light = "latte",
			dark = "mocha",
		},
		term_colors = false,
		integrations = {
			alpha = true,
			--bufferline = true,
			cmp = true,
			gitsigns = true,
			illuminate = true,
			indent_blankline = { enabled = true },
			lsp_trouble = true,
			mason = true,
			mini = true,
			native_lsp = {
				enabled = true,
				underlines = {
					errors = { "undercurl" },
					hints = { "undercurl" },
					warnings = { "undercurl" },
					information = { "undercurl" },
				},
			},
			navic = { enabled = true, custom_bg = "lualine" },
			neotest = true,
			noice = true,
			notify = true,
			neotree = true,
			semantic_tokens = true,
			telescope = true,
			treesitter = true,
			which_key = true,
		},
    highlight_overrides = {
      all = function(colors)
        return {
          BufferLineIndicatorSelected = {  fg = "#F38BA8", sp = "#F38BA8"},
  BufferLineTapSelected  = { bg="#F38BA8", fg = "#F38BA8", sp = "#F38BA8"},
  BufferLineTabSeparatorSelected = { bg="#F38BA8", fg = "#F38BA8", sp = "#F38BA8"},
  TabLine  = { bg="#F38BA8", fg = "#F38BA8", sp = "#F38BA8"},
  TabLineFill   = { bg="#F38BA8", fg = "#F38BA8", sp = "#F38BA8"},
  TabLineSel   = { bg="#F38BA8", fg = "#F38BA8", sp = "#F38BA8"},
        }
      end
    }
	})	vim.cmd.colorscheme("catppuccin")
end
