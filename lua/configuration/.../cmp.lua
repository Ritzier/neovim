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

local format = {
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

local source = {
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
      require('cmp_tabnine.compare'),
      cmp.config.compare.exact,
      cmp.config.compare.locality,
      cmp.config.compare.recently_used,
      cmp.config.compare.score,
      cmp.config.compare.offset,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
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
