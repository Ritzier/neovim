local present, _ = pcall(require, "rust-tools")
local pressent1, _ = pcall(require, "dap-install")

if present and pressent1 then
    local extension_path = vim.fn.stdpath("config") .. "vadimcn.vscode-lldb-1.7.0/"
    local codelldb_path = extension_path .. 'adapter/codelldb'
    local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'
    print(liblldb_path)
	local opts = {
        dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(
                codelldb_path, liblldb_path
            )
        }
    }
	require("rust-tools").setup({ opts })
end
