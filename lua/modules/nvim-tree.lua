local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
    view = {
        width = 30,
        height = 30,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        hide_root_folder = false,
    },
    renderer = {
        indent_markers = {
            enable = true,
            icons = {
                corner = "└ ",
                edge = "│ ",
                none = "  ",
            },
        },
        root_folder_modifier = ":e",
        icons = {
            padding = " ",
            symlink_arrow = "  ",
            glyphs = {
                ["default"] = "", --
                ["symlink"] = "",
                ["git"] = {
                    ["unstaged"] = "",
                    ["staged"] = "", --
                    ["unmerged"] = "שׂ",
                    ["renamed"] = "", --
                    ["untracked"] = "ﲉ",
                    ["deleted"] = "",
                    ["ignored"] = "", --◌
                },
                ["folder"] = {
                    -- ['arrow_open'] = "",
                    -- ['arrow_closed'] = "",
                    ["arrow_open"] = "",
                    ["arrow_closed"] = "",
                    ["default"] = "",
                    ["open"] = "",
                    ["empty"] = "",
                    ["empty_open"] = "",
                    ["symlink"] = "",
                    ["symlink_open"] = "",
                },
            },
        },
    },
    disable_netrw = false,
    hijack_netrw = true,
    respect_buf_cwd = true,
    filters = {
        custom = { ".git" },
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
})
