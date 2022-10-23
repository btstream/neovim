local function edit_config()
    vim.cmd("e " .. vim.fn.stdpath("config") .. "/" .. "init.lua")
end

local dashboard = require("dashboard")

local __header = {
    "",
    "      ╦           ┐                                                                                ",
    "   ╓▒╠╠▒╕        ╒╣▓╕                                                                              ",
    " ╓╣╬╬╬╠╠╠▒        ╣╣╣▓▄                                                     ╫██─                   ",
    "╒▒▒╠╬╬╬╠╠╠▒       ╣╣╣╣╣▌                                                                           ",
    "╒╠╠╠╠╣╬╠╠╠╠╠▒     ╣╣╣╣╣▌      ▐▌╓╧▀╙╙▀▄    ▄▀▀╙╙╙╗    ╓▌▀╙╙▀▀▄  ██▓     ▓██ ╟██─ ╟██▓████▓▄▓█████▌ ",
    "╒╠╠╠╠╠▒╣╠╠╠╠╠▒    ▓▓▓▓▓▌      ║█      ║▌  ▓─      ║╕ ▓▀      └█ ╙██▌   ╟██─ ╟██─ ╟██╩   ║██▌   ║██▌",
    "▐╠╠╠╠╠░ ╚╠╠╠╠╠╬╕  ▓▓▓▓▓▌      ║▌       █ ▐█╙╙╙╙╙╙╙▀▀ █        ╫▌ ╙██▄ ╔██╛  ╟██─ ╟██    ║██▌   ╒██▌",
    "▐╠╠╠╠╠▒  └╣╬╬╬╬╬▒╓▓▓▓▓▓▌      ║▌       █ └█          █        ▓▌  ╚██╗██▀   ╟██─ ╟██    ║██▌   ╒██▌",
    "▐╠╠╠╠╠▒    ╚╬╬╬╬╬╣▓▓▓▓▓▌      ║▌       █  ╙▓      ╓  ╙▓      ▄▀    ║███▀    ╟██─ ╟██    ║██▌   ╒██▌",
    "▐╠╠╠╠╠▒     └╣╬╬╬╣▓▓█▓▓▌      ╙└       ▀    └╙▀▀╙╙     └╙╙╙▀╙       ╙╙╙     ╙╙╙  ╙╙╙    └╙╙     ╙╙└",
    " ╩╬╬╬╬▒       ║╬╬╣▓▓▓██╙                                                                           ",
    "   ╚╬╬▒        ╙╣╣▓▓▓╙                                                                             ",
    "     ╙▒          ╣▀└                                                                               ",
}

dashboard.hide_statusline = false -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
-- dashboard.hide_tabline = false

dashboard.custom_header = __header
-- stylua: ignore
dashboard.custom_center = {
    { icon = "  ", desc = "Recently Opened Files          ", shortcut = "SPC f h", action = "Telescope oldfiles" },
    { icon = "  ", desc = "Open Project                   ", shortcut = "SPC f p", action = "Telescope projects" },
    { icon = "  ", desc = "Create New File                ", shortcut = "SPC c n", action = "enew" },
    { icon = "  ", desc = "Find File                      ", shortcut = "SPC f f", action = "Telescope find_files" },
    { icon = "  ", desc = "Find Word                      ", shortcut = "SPC f w", action = "Telescope live_grep" },
    { icon = "  ", desc = "Choosehoose Colorscheme        ", shortcut = "SPC t c", action = "Telescope colorscheme" },
    { icon = "  ", desc = "Configuration                  ", shortcut = "SPC s s", action = edit_config },
}

-- keymap
local map = vim.keymap.set
map("n", "<Leader>fh", "<cmd>Telescope oldfiles<CR>")
map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<Leader>tc", "<cmd>Telescope colorscheme<CR>")
map("n", "<Leader>fw", "<cmd>Telescope live_grep<CR>")
map("n", "<Leader>cn", "<cmd>enew<CR>")
map("n", "<Leader>fp", "<cmd>Telescope projects<cr>")
map("n", "<Leader>ss", edit_config)
