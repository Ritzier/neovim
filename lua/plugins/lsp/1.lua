local servers = require("plugins.lsp.servers_list")
for _, server in ipairs(servers) do
  local ok, handler = pcall(require, "plugins.lsp.servers."..server)
  if ok then
    print("Yes")
  else
    print("No")
  end
end
