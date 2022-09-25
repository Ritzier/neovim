local M = {}

function M.setup()
    require("mason").setup({

        github = {
            download_url_template = "https://github.com/fwcd/kotlin-debug-adapter/releases/download/0.4.3/adapter.zip"
        }
    })

    require("mason-tool-installer").setup({
        ensure_installed = {
            "codelldb",
            "stylua",
            "shfmt",
            "shellcheck",
            "prettierd",
            "netcoredbg",
            "chrome-debug-adapter",
        },
        auto_update = false,
        run_on_start = true,
    })
end

return M
