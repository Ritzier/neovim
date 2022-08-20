local configs = require("nvim-treesitter.configs")
configs.setup({
	ensure_installed = "all",
	highlight = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
    rainbow = { enable = true },
    endwise = { enable = true },
    autotag = {
        enable = true, 
        filetypes = {
            "html",
            "xml",
            "javascript",
            "typescriptreact",
            "javascriptreact",
            "vue",
        },
    },
    context_commentstring = {
        enable = true
    },
})
