if vim.loop.os_uname() == "Windows_NT" then
    vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "\\.config\\nvim\\my-snippets\\"
else
    vim.o.runtimepath = vim.o.runtimepath .. "," .. os.getenv("HOME") .. "/.config/nvim/my-snippets/,"
end
require("luasnip").config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
    delete_check_events = "TextChanged,InsertLeave",
})
require("luasnip.loaders.from_lua").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
