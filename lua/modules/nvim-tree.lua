require("nvim-tree").setup({
    -- disable netrw
    disable_netrw = false,
    -- hijack the netrw window
    hijack_netrw = false,
    -- keeps the cursor on the first letter of the filename when moving in the tree.
    hijack_cursor = true,
    -- refresh tree when changing root
    update_cwd = true,
    -- ignored file types
    ignore_ft_on_setup = { "dashboard" },
    -- auto-reload tree (bufenter event)
    reload_on_bufenter = true,
    -- update the focused file on `bufenter`, un-collapses the folders recursively
    -- until it finds the file.
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        side = "left",
        width = 30,
        hide_root_folder = false,
        signcolumn = "yes",
    },
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    actions = {
        use_system_clipboard = true,
        change_dir = {
            enable = true,
            global = true,
            restrict_above_cwd = false,
        },
        open_file = {
            resize_window = true,
            window_picker = {
                enable = true,
            },
        },
    },
    trash = {
        cmd = "trash",
        require_confirm = true,
    },
    filters = {
        dotfiles = false,
        custom = { "node_modules", "\\.cache", "__pycache__" },
        exclude = {},
    },
    renderer = {
        add_trailing = true,
        highlight_git = true,
        highlight_opened_files = "none",
        icons = {
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
            glyphs = {
                default = "",
                symlink = "",
                folder = {
                    arrow_open = "",
                    arrow_closed = "",
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                    symlink_open = "",
                },
            },
        },
    },
})
