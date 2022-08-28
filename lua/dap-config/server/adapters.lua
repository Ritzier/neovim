local dap = require("dap")

-- lldb
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb',
}

-- coreclr
dap.adapters.coreclr = {
  type = "executable",
  command = "/usr/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}

-- debugpy
dap.adapters.python = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

-- nlua
dap.adapters.nlua = function(callback, config)
  callback { type = 'server', host = config.host, port = config.port }
end
