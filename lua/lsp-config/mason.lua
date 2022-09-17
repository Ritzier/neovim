local M = {}

function M.setup()
    require("mason").setup()

    require("mason-tool-installer").setup({
        ensure_installed = { "codelldb", "stylua", "shfmt", "shellcheck", "prettierd" },
        auto_update = false,
        run_on_start = true,
    })
end

return M
