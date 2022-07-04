local present1, _ = pcall(require, "attempt")
local present2, _ = pcall(require, "telescope")

if present1 and present2 then
    require("attempt").setup()
    require("telescope").load_extension "attempt"
end
