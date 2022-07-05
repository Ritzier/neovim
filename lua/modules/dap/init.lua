local present1, _ = pcall(require, "nvim-dap-virtual-text")
local present2, _ = pcall(require, "dap-install")
local present3, _ = pcall(require, "dap")
local present4, _ = pcall(require, "dapui")

if present1 and present2 and present3 and present4 then
	local function configure()
		local dap_install = require("dap-install")
		dap_install.setup({
			installation_path = vim.fn.stdpath("data") .. "/dapinstall/",
		})

		local dap_breakpoint = {
			error = {
				text = "🟥",
				texthl = "LspDiagnosticsSignError",
				linehl = "",
				numhl = "",
			},
			rejected = {
				text = "",
				texthl = "LspDiagnosticsSignHint",
				linehl = "",
				numhl = "",
			},
			stopped = {
				text = "⭐️",
				texthl = "LspDiagnosticsSignInformation",
				linehl = "DiagnosticUnderlineInfo",
				numhl = "LspDiagnosticsSignInformation",
			},
		}

		vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
		vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
		vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
	end

	local function configure_exts()
		require("nvim-dap-virtual-text").setup({
			commented = true,
		})

		local dap, dapui = require("dap"), require("dapui")
		dapui.setup({}) -- use default
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end

	local function configure_debuggers()
		require("modules.dap.lua").setup()
		require("modules.dap.python").setup()
		require("modules.dap.rust").setup()
		require("modules.dap.go").setup()
		require("modules.dap.csharp").setup()
		require("modules.dap.kotlin").setup()
		require("modules.dap.typescript").setup()
	end

	function setup()
		configure() -- Configuration
		configure_exts() -- Extensions
		configure_debuggers() -- Debugger
		require("modules.dap.keymaps").setup() -- Keymaps
	end

    setup()
end
