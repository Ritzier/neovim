-- require("nvim-autopairs").setup({
--   check_ts = true,
--   ts_config = {
--     lua = {"string"},
--     javascript = {"template_string"},
--     java = false,
--   }
-- })
--
-- -- If you want insert `(` after select function or method item
-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
-- local cmp = require("cmp")
-- local handlers = require("nvim-autopairs.completion.handlers")
-- cmp.event:on(
--   "confirm_done",
--   cmp_autopairs.on_confirm_done({
--     filetypes = {
--       -- "*" is an alias to all filetypes
--       ["*"] = {
--         ["("] = {
--           kind = {
--             cmp.lsp.CompletionItemKind.Function,
--             cmp.lsp.CompletionItemKind.Method,
--           },
--           handler = handlers["*"],
--         },
--       },
--       -- Disable for tex
--       tex = false,
--     },
--     map_char = {
--       tex=""
--     }
--   })
-- )

require('nvim-autopairs').setup({
  check_ts = true,
  ts_config = {
    lua = { 'string' },
    javascript = { 'template_string' },
    java = false,
  }
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
