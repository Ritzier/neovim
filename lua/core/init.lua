local function colorscheme_duskfox()
    local present, module = pcall(require, "nightfox")
    if present then
        vim.cmd("colorscheme duskfox")
    end
end

local function neovide_config()
    vim.cmd([[set guifont=FiraCode\ NF\:h11]])
    vim.g.neovide_refresh_rate = 200
    vim.g.neovide_cursor_vfx_mode = "railgun"
    vim.g.neovide_no_idle = true
    vim.g.neovide_cursor_animation_length = 0.03
end

require("core.options")
require("core.autocmd")
require("core.mappings")
colorscheme_duskfox()
neovide_config()
