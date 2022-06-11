local function edit_config()
    vim.cmd("e " .. vim.fn.stdpath("config") .. "/" .. "init.lua")
end

local dashboard = require("dashboard")
dashboard.custom_header = {
    "",
    "      ╦           ┐",
    "   ╓▒╠╠▒╕        ╒╣▓╕",
    " ╓╣╬╬╬╠╠╠▒        ╣╣╣▓▄                                                     ╫██─",
    "╒▒▒╠╬╬╬╠╠╠▒       ╣╣╣╣╣▌",
    "╒╠╠╠╠╣╬╠╠╠╠╠▒     ╣╣╣╣╣▌      ▐▌╓╧▀╙╙▀▄    ▄▀▀╙╙╙╗    ╓▌▀╙╙▀▀▄  ██▓     ▓██ ╟██─ ╟██▓████▓▄▓█████▌",
    "╒╠╠╠╠╠▒╣╠╠╠╠╠▒    ▓▓▓▓▓▌      ║█      ║▌  ▓─      ║╕ ▓▀      └█ ╙██▌   ╟██─ ╟██─ ╟██╩   ║██▌   ║██▌",
    "▐╠╠╠╠╠░ ╚╠╠╠╠╠╬╕  ▓▓▓▓▓▌      ║▌       █ ▐█╙╙╙╙╙╙╙▀▀ █        ╫▌ ╙██▄ ╔██╛  ╟██─ ╟██    ║██▌   ╒██▌",
    "▐╠╠╠╠╠▒  └╣╬╬╬╬╬▒╓▓▓▓▓▓▌      ║▌       █ └█          █        ▓▌  ╚██╗██▀   ╟██─ ╟██    ║██▌   ╒██▌",
    "▐╠╠╠╠╠▒    ╚╬╬╬╬╬╣▓▓▓▓▓▌      ║▌       █  ╙▓      ╓  ╙▓      ▄▀    ║███▀    ╟██─ ╟██    ║██▌   ╒██▌",
    "▐╠╠╠╠╠▒     └╣╬╬╬╣▓▓█▓▓▌      ╙└       ▀    └╙▀▀╙╙     └╙╙╙▀╙       ╙╙╙     ╙╙╙  ╙╙╙    └╙╙     ╙╙└",
    " ╩╬╬╬╬▒       ║╬╬╣▓▓▓██╙",
    "   ╚╬╬▒        ╙╣╣▓▓▓╙",
    "     ╙▒          ╣▀└",
    "",
}

dashboard.hide_statusline = false -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
dashboard.hide_tabline = false

-- stylua: ignore
dashboard.custom_center = {
    { icon = "  ", desc = "Recently Opened Files          ", shortcut = "SPC f h", action = "Telescope oldfiles" },
    { icon = "  ", desc = "Open Project                   ", shortcut = "SPC f p", action = "Telescope projects" },
    { icon = "  ", desc = "Create New File                ", shortcut = "SPC c n", action = "DashboardNewFile" },
    { icon = "  ", desc = "Find File                      ", shortcut = "SPC f f", action = "Telescope find_files" },
    { icon = "  ", desc = "Find Word                      ", shortcut = "SPC f w", action = "Telescope live_grep" },
    { icon = "  ", desc = "Choosehoose Colorscheme        ", shortcut = "SPC t c", action = "Telescope colorscheme" },
    -- { icon = "  ", desc = "Update Plugins                 ", shortcut = "SPC p u", action = "PackerUpdate" },
    { icon = "  ", desc = "Configuration                  ", shortcut = "SPC s s", action = edit_config },
}

-- vim.g.dashboard_preview_action = "cat"
-- vim.g.dashboard_preview_pipeline = "cat"
-- vim.g.dashboard_preview_file = "~/.config/nvim/neovim_logo.dat"
-- vim.g.dashboard_preview_file_height = 14
-- vim.g.dashboard_preview_file_width = 80
-- vim.g.dashboard_custom_footer = {
--     "",
-- }

local map = vim.keymap.set
map("n", "<Leader>fh", "<cmd>DashboardFindHistory<CR>")
map("n", "<Leader>ff", "<cmd>DashboardFindFile<CR>")
map("n", "<Leader>tc", "<cmd>DashboardChangeColorscheme<CR>")
map("n", "<Leader>fw", "<cmd>DashboardFindWord<CR>")
map("n", "<Leader>fb", "<cmd>DashboardJumpMark<CR>")
map("n", "<Leader>cn", "<cmd>DashboardNewFile<CR>")
map("n", "<Leader>fp", "<cmd>Telescope projects<cr>")
map("n", "<Leader>pu", "<cmd>PackerUpdate<cr>")
map("n", "<Leader>ss", edit_config)
