local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local cmp = require("cmp")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspkind = require("lspkind")

local source_mapping = {
	npm = "   NPM",
	cmp_tabnine = "  ",
	nvim_lsp = "  LSP",
	buffer = " ﬘ BUF",
	nvim_lua = "  ",
	luasnip = "  SNP",
	calc = "  ",
	path = " ﱮ ",
	treesitter = "  ",
	zsh = "   ZSH",
}

local format = {
	format = function(entry, vim_item)
		vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
		local menu = source_mapping[entry.source.name]
		local maxwidth = 50

		if entry.source.name == "cmp_tabnine" then
			if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
				menu = menu .. entry.completion_item.data.detail
			else
				menu = menu .. "TBN"
			end
		end

		vim_item.menu = menu
		vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

		return vim_item
	end,
}

local source = {
	{ name = "nvim_lsp" },
	{ nmae = "nvim_lua" },
	{ name = "npm" },
	{ name = "luasnip" },
	{ name = "buffer" },
	{ name = "path" },
	{ name = "luasnip" },
	{ name = "latex_symbols" },
}

local compare = require("cmp.config.compare")

cmp.setup({
	completion = { completeopt = "menu,menuone,noinsert" },
	window = {
    completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		--[[ ["<CR>"] = cmp.mapping.confirm({ select = true }), ]]
		["<A-CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-e>"] = cmp.mapping.close(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-h>"] = function(fallback)
			if require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
			else
				fallback()
			end
		end,
		["<C-l>"] = function(fallback)
			if require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
			else
				fallback()
			end
		end,
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = format,
	sources = source,
  sorting = {
    comparators = {
      compare.offset,
			compare.exact,
			compare.locality,
			compare.score,
      require("clangd_extensions.cmp_scores"),
			require("cmp-under-comparator").under,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
    }
  }
})
