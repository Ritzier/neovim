local M = {}
function M.mason(servers)
  local lspconfig = require("lspconfig")
  require("mason").setup({
    ui = {
      icons = {
        check_outdated_packages_on_open = true,
        border = "none",
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  require("mason-tool-installer").setup({
    ensure_installed = {
      "bash-language-server",
      "black",
      "chrome-debug-adapter",
      "codelldb",
      "cpplint",
      "css-lsp",
      "eslint-lsp",
      "flake8",
      "goimports",
      "graphql-language-service-cli",
      "hadolint",
      "html-lsp",
      "json-lsp",
      "lua-language-server",
      "node-debug2-adapter",
      "prettierd",
      "prisma-language-server",
      "rubocop",
      "shellcheck",
      "shfmt",
      "stylua",
      "tailwindcss-language-server",
      "typescript-language-server",
      "vetur-vls",
      "vint",
      "vue-language-server",
      "xo",
    },
    auto_update = true,
    run_on_start = true,
    automatic_installation = true,
  })
end

return M
