require("dap").configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = 'Launch file',
    program = '${file}',
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/usr/bin/python3.9') == 1 then
        return cwd .. "/usr/bin/python3.9"
      else
        print("Please install Python3.9")
        return ""
      end
    end,
  },
}
