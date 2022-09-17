local function set_sidebar_icons()
    local diagnostic_icons = {
        Error = " ",
        Warn = " ",
        Info = " ",
        Hint = " ",
    }
    for type, icon in pairs(diagnostic_icons) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl })
    end
end

local function get_palette()
    if vim.g.colors_name == "catppuccin" then
        -- If the colorscheme is catppuccin then use the palette.
        return require("catppuccin.palettes").get_palette()
    else
        -- Default behavior: return lspsaga's default palette.
        local palette = require("lspsaga.lspkind").colors
        palette.peach = palette.orange
        palette.flamingo = palette.orange
        palette.rosewater = palette.yellow
        palette.mauve = palette.violet
        palette.sapphire = palette.blue
        palette.maroon = palette.orange

        return palette
    end
end

set_sidebar_icons()

local colors = get_palette()

require("lspsaga").init_lsp_saga({
    diagnostic_header = { " ", " ", "  ", " " },
    custom_kind = {
        File = { " ", colors.rosewater },
        Module = { " ", colors.blue },
        Namespace = { " ", colors.blue },
        Package = { " ", colors.blue },
        Class = { "ﴯ ", colors.yellow },
        Method = { " ", colors.blue },
        Property = { "ﰠ ", colors.teal },
        Field = { " ", colors.teal },
        Constructor = { " ", colors.sapphire },
        Enum = { " ", colors.yellow },
        Interface = { " ", colors.yellow },
        Function = { " ", colors.blue },
        Variable = { " ", colors.peach },
        Constant = { " ", colors.peach },
        String = { " ", colors.green },
        Number = { " ", colors.peach },
        Boolean = { " ", colors.peach },
        Array = { " ", colors.peach },
        Object = { " ", colors.yellow },
        Key = { " ", colors.red },
        Null = { "ﳠ ", colors.yellow },
        EnumMember = { " ", colors.teal },
        Struct = { " ", colors.yellow },
        Event = { " ", colors.yellow },
        Operator = { " ", colors.sky },
        TypeParameter = { " ", colors.maroon },
        -- ccls-specific icons.
        TypeAlias = { " ", colors.green },
        Parameter = { " ", colors.blue },
        StaticMethod = { "ﴂ ", colors.peach },
        Macro = { " ", colors.red },
    },
})
