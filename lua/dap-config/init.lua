local language = {
  "c",
  "cpp",
  "cs",
  "lua",
  "ptyhon",
}

require("dap-config.ui")

require("dap-config.dapinstall")

require("dap-config.server.adapters")

require("dap-config.dap_configuration")(language)

require("dap-config.keymaps")
