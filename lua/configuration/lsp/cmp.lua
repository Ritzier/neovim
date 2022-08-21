local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
local cmp_window = require("cmp.utils.window")

function cmp_window:has_scrollbar()
  return false
end

local border = function(hl)
  return {
    { "╭", hl },
    { "─", hl },
    { "╮", hl },
    { "│", hl },
    { "╯", hl },
    { "─", hl },
    { "╰", hl },
    { "│", hl },
  }
end


local lspkind = require("lspkind")

local window1 = {
  completion = {
    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    col_offset = -3,
    side_padding = 0,
  }
}

local format1 = {
  fields = { "kind", "abbr", "menu" },
  format = function(entry, vim_item)
    local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 60 })(entry, vim_item)
    local strings = vim.split(kind.kind, "%s", { trimempty = true })
    kind.kind = " " .. strings[1] .. " "
    kind.menu = "    (" .. strings[2] .. ")"

    return kind
  end,

}

local source_mapping = {
  buffer = "[Buffer]",
  nvim_lsp = "[LSP]",
  nvim_lua = "[Lua]",
  cmp_tabnine = "[TN]",
  path = "[Path]",
}

local format3 = {
  format = function(entry, vim_item)
    vim_item.kind = lspkind.symbolic(vim_item.kind, { with_text = true })
    local menu = source_mapping[entry.source.name]
    local maxwidth = 50

    if entry.source.name == 'cmp_tabnine' then
      if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
        menu = menu .. entry.completion_item.data.detail
      else
        menu = menu .. 'TBN'
      end
    end

    vim_item.menu = menu
    vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)

    return vim_item
  end
}

local source1 = {
  { name = "nvim_lsp" },
  { name = "nvim_lua" },
  { name = "luasnip" },
  { name = "path" },
  { name = "buffer" },
  { name = "latex_symbols" },
  { name = "cmp_tabnine" },
}

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end
}

local source2 = {
  { name = 'nvim_lsp', priority = 9 },
  { name = 'npm', priority = 9 },
  { name = 'cmp_tabnine', priority = 8, max_num_results = 3 },
  { name = 'luasnip', priority = 7, max_item_count = 8 },
  { name = 'buffer', priority = 7, keyword_length = 5, option = buffer_option, max_item_count = 8 },
  { name = 'nvim_lua', priority = 5 },
  { name = 'path', priority = 4 },
  { name = 'luasnipo' },
  { name = "latex_symbols" },
}

local cmp = require("cmp")
require("cmp").setup({
  window = {
    completion = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    }),
    documentation = cmp.config.window.bordered({
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
    }),
  },

  formatting = format3,

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
  -- You should specify your *installed* sources.
  sources = source2,
  sorting = {
    comparators = {
      cmp.config.compare.exact,
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.sort_text,
      cmp.config.compare.order,
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = true,
  },
})

require("cmp_tabnine.config").setup({
  max_lines = 1000,
  max_num_results = 3,
  sort = true,
  show_prediction_strength = true,
  run_on_every_keystroke = true,
  snipper_placeholder = "..",
  ignored_file_types = {},

})

vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", { fg = "#808080" })
vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#ee99a0" })

vim.api.nvim_set_hl(0, "CmpItemKindField", { fg = "#f38ba8" })

vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#8aadf4" })
vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#8aadf4" })

vim.api.nvim_set_hl(0, "CmpItemKindVariable", { fg = "#91d7ec" })
vim.api.nvim_set_hl(0, "CmpItemKindInterface", { fg = "#91d7ec" })
vim.api.nvim_set_hl(0, "CmpItemKindText", { fg = "#91d7ec" })

vim.api.nvim_set_hl(0, "CmpItemKindFunction", { fg = "#c6a0f6" })
vim.api.nvim_set_hl(0, "CmpItemKindMethod", { fg = "#c6a0f6" })

vim.api.nvim_set_hl(0, "CmpItemKindKeyword", { fg = "#f4dbd6" })
vim.api.nvim_set_hl(0, "CmpItemKindProperty", { fg = "#f4dbd6" })
vim.api.nvim_set_hl(0, "CmpItemKindUnit", { fg = "#f4dbd6" })

-- vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#282C34", fg = "NONE" })
-- vim.api.nvim_set_hl(0,"Pmenu" , { fg = "#C5CDD9", bg = "#22252A" })
--
-- vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated" , { fg = "#7E8294", bg = "NONE" })
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatch" , { fg = "#82AAFF", bg = "NONE", bold=true })
-- vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy" , { fg = "#82AAFF", bg = "NONE", bold=true })
-- vim.api.nvim_set_hl(0, "CmpItemMenu" , { fg = "#cba6f7", bg = "NONE", italic=true })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindField" , { fg = "#181825", bg = "#f38ba8" })
-- vim.api.nvim_set_hl(0, "CmpItemKindProperty" , { fg = "#EED8DA", bg = "#f38ba8" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEvent" , { fg = "#EED8DA", bg = "#f38ba8" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindText" , { fg = "#45475A", bg = "#a6e3a1" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEnum" , { fg = "#45475A", bg = "#a6e3a1" })
-- vim.api.nvim_set_hl(0, "CmpItemKindKeyword" , { fg = "#45475A", bg = "#94e2d5" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindConstant" , { fg = "#FFE082", bg = "#D4BB6C" })
-- vim.api.nvim_set_hl(0, "CmpItemKindConstructor" , { fg = "#FFE082", bg = "#D4BB6C" })
-- vim.api.nvim_set_hl(0, "CmpItemKindReference" , { fg = "#FFE082", bg = "#D4BB6C" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindFunction" , { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindStruct" , { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindClass" , { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindModule" , { fg = "#EADFF0", bg = "#A377BF" })
-- vim.api.nvim_set_hl(0, "CmpItemKindOperator" , { fg = "#EADFF0", bg = "#A377BF" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindVariable" , { fg = "#C5CDD9", bg = "#7E8294" })
-- vim.api.nvim_set_hl(0, "CmpItemKindFile" , { fg = "#C5CDD9", bg = "#7E8294" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindUnit" , { fg = "#F5EBD9", bg = "#D4A959" })
-- vim.api.nvim_set_hl(0, "CmpItemKindSnippet" , { fg = "#F5EBD9", bg = "#D4A959" })
-- vim.api.nvim_set_hl(0, "CmpItemKindFolder" , { fg = "#F5EBD9", bg = "#D4A959" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindMethod" , { fg = "#DDE5F5", bg = "#6C8ED4" })
-- vim.api.nvim_set_hl(0, "CmpItemKindValue" , { fg = "#DDE5F5", bg = "#6C8ED4" })
-- vim.api.nvim_set_hl(0, "CmpItemKindEnumMember" , { fg = "#DDE5F5", bg = "#6C8ED4" })
--
-- vim.api.nvim_set_hl(0, "CmpItemKindInterface" , { fg = "#D8EEEB", bg = "#58B5A8" })
-- vim.api.nvim_set_hl(0, "CmpItemKindColor" , { fg = "#D8EEEB", bg = "#58B5A8" })
-- vim.api.nvim_set_hl(0, "CmpItemKindTypeParameter" , { fg = "#D8EEEB", bg = "#58B5A8" })
