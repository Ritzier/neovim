vim.cmd("colorscheme rose-pine")

local M = {}
M.colors_scheme = {"gruvbox", "duskfox", "tokyonight", "rose-pine", }
local max = 0
for _ in pairs(M.colors_scheme) do
    max = max + 1
end
local n = 0

function M.switch_colorscheme()
    if n == max then
        n = 0
    end
    n = n+1
    color = M.colors_scheme[n]
    vim.cmd("colorscheme " .. color)
    local text = "Colorscheme: " .. color
    vim.notify(text, "info")
end

vim.keymap.set("n", "<C-b>", ":lua require('modules.colorscheme').switch_colorscheme()<CR>", {noremap=true, silent=false})

return M
