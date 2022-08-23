local M = {}

function M.attach(client, bufnr)
  local opts = { noremap = true, silent = true }
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local navic = require("nvim-navic")
  local gps = require("nvim-gps")
  vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  --[[ vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts) ]]
  vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", bufopts)
  vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

  vim.keymap.set("n", "<leader>llc", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "<leader>llD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "<leader>lld", vim.lsp.buf.definition, bufopts)
  -- vim.keymap.set("n", "<leader>llf", vim.lsp.buf.formatting, bufopts)
  vim.keymap.set("n", "<leader>llf", ":lua vim.lsp.buf.format {async=true}<CR>", bufopts)
  vim.keymap.set("n", "<leader>llh", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<leader>lli", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<leader>lls", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>lln", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>llr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>llt", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>llwa", vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>llwr", vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set("n", "<leader>llwl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set("n", "<leader>ltt", "<cmd>TroubleToggle<cr>", bufopts)
  vim.keymap.set("n", "<leader>ltq", "<cmd>TroubleToggle<cr> quickfix<cr>", bufopts)
  vim.keymap.set("n", "<leader>ltr", "<cmd>TroubleToggle<cr> lsp_references<cr>", bufopts)
  vim.keymap.set("n", "<leader>ltl", "<cmd>TroubleToggle<cr> loclist<cr>", bufopts)

  vim.keymap.set("n", "<leader>lgd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", bufopts)
  vim.keymap.set("n", "<leader>lgt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", bufopts)
  vim.keymap.set("n", "<leader>lgi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", bufopts)
  vim.keymap.set("n", "<leader>lgc", "<cmd>lua require('goto-preview').close_all_win()<CR>", bufopts)
  vim.keymap.set("n", "<leader>lgr", "<cmd>lua require('goto-preview').goto_preview_reference", bufopts)

  vim.keymap.set("n", "<leader>lsr", "<cmd>Lspsaga rename<cr>", bufopts)
  vim.keymap.set("n", "<leader>lsc", "<cmd>Lspsaga code_action<cr>", bufopts)
  vim.keymap.set("x", "<leader>lsc", ":<c-u>Lspsaga range_code_action<cr>", bufopts)
  vim.keymap.set("n", "<leader>lsk", "<cmd>Lspsaga hover_doc<cr>", bufopts)
  vim.keymap.set("n", "<leader>lss", "<cmd>Lspsaga show_line_diagnostics<cr>", bufopts)
  vim.keymap.set("n", "<leader>lsn", "<cmd>Lspsaga diagnostic_jump_next<cr>", bufopts)
  vim.keymap.set("n", "<leader>lsp", "<cmd>Lspsaga diagnostic_jump_prev<cr>", bufopts)
  -- vim.keymap.set("n", "", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
  -- vim.keymap.set("n", "", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

  require("lsp_signature").on_attach({
    bind = true,
    use_lspsaga = false,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hi_parameter = "Search",
    handler_opts = { "double" },
  })

  if client.name ~= "tailwindcss"
      and client.name ~= "bashls"
      and client.name ~= "html"
      and client.name ~= "angularls"
      and client.name ~= "efm"
      and client.name ~= "cssls"
  then
    navic.attach(client, bufnr)
    require("lualine").setup({
      sections = {
        lualine_c = {
          { navic.get_location, cond = navic.is_available },
        },
      },
    })
  else
    require("lualine").setup({
      sections = {
        lualine_c = {
          { gps.get_location, cond = gps.is_available },
        },
      },
    })
  end
end

local codes = require("configuration.lsp.codes")
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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

function M.setup(servers)
  for _, server in ipairs(servers) do
    if server == "sumneko_lua" then
      require("lspconfig")[server].setup({
        on_attach = M.attach,
        capabilities = capabilities,
      })

    elseif server == "jsonls" then
      require("lspconfig")[server].setup({
        on_attach = M.attach,
        capabilities = capabilities,
        require("configuration.lsp.servers.jsonls")
      })

    elseif server == "clangd" then
      local copy_capabilities = capabilities
      copy_capabilities.offsetEncoding = { "utf-16" }
      require("lspconfig")[server].setup({
        capabilities = copy_capabilities,
        on_attach = M.attach,
        require("configuration.lsp.servers.clangd")
      })

    elseif server == "vuels" then
      require("lspconfig")[server].setup({
        on_attach = M.attach,
        capabilities = capabilities,
        require("configuration.lsp.servers.vuels")
      })

    elseif server == "cssls" then
      require("lspconfig")[server].setup({
        on_attach = require("configuration.lsp.servers.cssls").attach,
        capabilities = require("configuration.lsp.servers.cssls").capabilities
      })

    elseif server == "gopls" then
      require("lspconfig")[server].setup({
        on_attach = M.attach,
        capabilities = capabilities,
        require("configuration.lsp.servers.gopls")
      })

    elseif server == "html" then
      require("lspconfig")[server].setup({
        on_attach = M.attach,
        capabilities = capabilities,
        require("configuration.lsp.servers.html")
      })

    elseif server == "tsserver" then
      require("lspconfig")[server].setup({
        capabilities = require("configuration.lsp.servers.tsserver").capabilities,
        on_attach = M.attach
      })

    elseif server == "rust_analyzer" then
      require("configuration.lsp.rust_analyzer")

    else
      require("lspconfig")[server].setup({
        on_attach = M.attach,
        capabilities = capabilities,
      })
    end
  end
end

return M
