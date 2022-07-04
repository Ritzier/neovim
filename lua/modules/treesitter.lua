local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local present1, _ = pcall(require, "nvim-treesitter-endwise")
local present2, _ = pcall(require, "nvim-ts-rainbow")

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	indent = { enable = true, disable = { "python", "css" } },
    rainbow = { enable = true },
    endwise = { enable = true },
})
