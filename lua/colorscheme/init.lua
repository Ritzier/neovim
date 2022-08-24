local M = {}
local hex_re = vim.regex "#\\x\\x\\x\\x\\x\\x"

local HEX_DIGITS = {
  ["0"] = 0,
  ["1"] = 1,
  ["2"] = 2,
  ["3"] = 3,
  ["4"] = 4,
  ["5"] = 5,
  ["6"] = 6,
  ["7"] = 7,
  ["8"] = 8,
  ["9"] = 9,
  ["a"] = 10,
  ["b"] = 11,
  ["c"] = 12,
  ["d"] = 13,
  ["e"] = 14,
  ["f"] = 15,
  ["A"] = 10,
  ["B"] = 11,
  ["C"] = 12,
  ["D"] = 13,
  ["E"] = 14,
  ["F"] = 15,
}

local function hex_to_rgb(hex)
  return HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + HEX_DIGITS[string.sub(hex, 2, 2)],
    HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + HEX_DIGITS[string.sub(hex, 4, 4)],
    HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + HEX_DIGITS[string.sub(hex, 6, 6)]
end

local function rgb_to_hex(r, g, b)
  return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local function darken(hex, pct)
  pct = 1 - pct
  local r, g, b = hex_to_rgb(string.sub(hex, 2))
  r = math.floor(r * pct)
  g = math.floor(g * pct)
  b = math.floor(b * pct)
  return string.format("#%s", rgb_to_hex(r, g, b))
end

-- M.colorscheme["yuki"] = {
--   base00 = ""
-- }

-- vim.api.nvim_set_hl(0, "rainbowcol1", {fg="#4495C1"})
-- vim.api.nvim_set_hl(0, "rainbowcol2", {fg="#3cb0b4"})
-- vim.api.nvim_set_hl(0, "rainbowcol3", {fg="#71D0b8"})
vim.api.nvim_set_hl(0, "rainbowcol1", {fg="#415BC0"})
vim.api.nvim_set_hl(0, "rainbowcol2", {fg="#3A8DB1"})
vim.api.nvim_set_hl(0, "rainbowcol3", {fg="#78D4BF"})
vim.api.nvim_set_hl(0, "rainbowcol4", {fg="#2E8471"})
vim.api.nvim_set_hl(0, "rainbowcol5", {fg="#789BD2"})
vim.api.nvim_set_hl(0, "rainbowcol6", {fg="#2f4f83"})
vim.api.nvim_set_hl(0, "rainbowcol7", {fg="#52C6A8"})



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
