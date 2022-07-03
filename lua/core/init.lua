local function colorscheme_duskfox()
    local present, module = pcall(require, "nightfox")
    if present then
        vim.cmd("colorscheme duskfox")
    end
end
require("core.options")
require("core.autocmd")
require("core.mappings")
colorscheme_duskfox()
