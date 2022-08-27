local M = {}

local codes = require("lsp.codes")
vim.diagnostic.config({
  float = {
    source = false,
    format = function(diagnostic)
      local code = diagnostic.user_data.lsp.code

      if not diagnostic.source or not code then
        return string.format('%s', diagnostic.message)
      end

      if diagnostic.source == 'eslint' then
        for _, table in pairs(codes) do
          if vim.tbl_contains(table, code) then
            return string.format('%s [%s]', table.icon .. diagnostic.message, code)
          end
        end

        return string.format('%s [%s]', diagnostic.message, code)
      end

      for _, table in pairs(codes) do
        if vim.tbl_contains(table, code) then
          return table.message
        end
      end

      return string.format('%s [%s]', diagnostic.message, diagnostic.source)
    end
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
  },
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = require("lsp.server.default").capabilities
local attach = require("lsp.server.default").on_attach

function M.setup(servers)
  for _, server in ipairs(servers) do
    if server == "sumneko_lua" then
      local opt = require("lsp.server.sumneko_lua")
      require("lspconfig")[server].setup(opt)

    elseif server == "jsonls" then
      require("lspconfig")[server].setup({
        on_attach = attach,
        capabilities = capabilities,
        require("lsp.server.jsonls")
      })

    elseif server == "clangd" then
      require("lsp.server.clangd")

    elseif server == "vuels" then
      require("lspconfig")[server].setup({
        on_attach = attach,
        capabilities = capabilities,
        require("lsp.server.vuels")
      })

    elseif server == "cssls" then
      capabilities = require("lsp.server.cssls").capabilities
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      require("lspconfig")[server].setup({
        on_attach = require("lsp.server.cssls").attach,
        capabilities = capabilities,
      })

    elseif server == "gopls" then
      require("lspconfig")[server].setup({
        on_attach = attach,
        capabilities = capabilities,
        require("lsp.server.gopls")
      })

    elseif server == "html" then
      require("lspconfig")[server].setup({
        on_attach = attach,
        capabilities = capabilities,
        require("lsp.server.html")
      })

    elseif server == "tsserver" then
      require("lspconfig")[server].setup({
        capabilities = require("lsp.server.tsserver").capabilities,
        on_attach = attach
      })

    elseif server == "rust_analyzer" then
      require("lsp.server.rust_analyzer")

    else
      require("lspconfig")[server].setup({
        on_attach = attach,
        capabilities = capabilities,
      })
    end
  end
end

return M
