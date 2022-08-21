local dashboard = require("alpha.themes.dashboard")
local alpha = require("alpha")
dashboard.section.header.val = {
  "          ▄▄▄  ▪  ▄▄▄▄▄·▄▄▄▄•▪  ▄▄▄ .▄▄▄  ",
  "          ▀▄ █·██ •██  ▪▀·.█▌██ ▀▄.▀·▀▄ █·",
  "         ▐▀▀▄ ▐█· ▐█.▪▄█▀▀▀•▐█·▐▀▀▪▄▐▀▀▄ ",
  "         ▐█•█▌▐█▌ ▐█▌·█▌▪▄█▀▐█▌▐█▄▄▌▐█•█▌",
  "         .▀  ▀▀▀▀ ▀▀▀ ·▀▀▀ •▀▀▀ ▀▀▀ .▀  ▀",
}

local thingy = io.popen('echo "$(date +%a) $(date +%d) $(date +%b)" | tr -d "\n"')
if thingy == nil then return end
local date = thingy:read("*a")
thingy:close()

local datetime = os.date " %H:%M"

local text1 =  "┌────────────   Today is " .. date .. " ────────────┐"

dashboard.section.buttons.val = {
	dashboard.button("f", text1, ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
	return "chrisatmachine.com"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
