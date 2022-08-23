local opt = {}

opt.attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = true
  client.server_capabilities.documentRangeFormattingProvider = true
end

opt.capabilities = function(cap)
  local cp = cap
  cp.textDocument.completion.completionItem.snippetSupport = true
  return cp
end

return opt
