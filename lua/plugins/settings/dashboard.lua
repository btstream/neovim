vim.g.dashboard_default_executive = "telescope"
vim.g.dashboard_custom_section = {
    a = { description = { "  Recently Opened Files          SPC f h" }, command = "Telescope oldfiles" },
    b = { description = { "  Open Project                   SPC f p" }, command = "Telescope projects" },
    c = { description = { "  Create New File                SPC c n" }, command = "DashboardNewFile" },
    d = { description = { "  Find File                      SPC f f" }, command = "Telescope find_files" },
    e = { description = { "  Find Word                      SPC f w" }, command = "Telescope live_grep" },
    f = { description = { "  Choose Colorscheme             SPC t c" }, command = "Telescope colorscheme" },
    g = { description = { "  Update Plugins                 SPC p u" }, command = "PackerUpdate" },
    h = { description = { "  Configuration                  SPC s s" }, command = ":e ~/.config/nvim/init.lua" },
}

vim.g.dashboard_custom_header = {
    "",
    "",
    "",
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
-- vim.g.dashboard_preview_command = "cat"
-- vim.g.dashboard_preview_pipeline = "cat"
-- vim.g.dashboard_preview_file = "~/.config/nvim/neovim_logo.dat"
-- vim.g.dashboard_preview_file_height = 14
-- vim.g.dashboard_preview_file_width = 80

vim.g.dashboard_custom_footer = {
    "",
}

local map = vim.keymap.set

map("n", "<Leader>fh", ":DashboardFindHistory<CR>")
map("n", "<Leader>ff", ":DashboardFindFile<CR>")
map("n", "<Leader>tc", ":DashboardChangeColorscheme<CR>")
map("n", "<Leader>fw", ":DashboardFindWord<CR>")
map("n", "<Leader>fb", ":DashboardJumpMark<CR>")
map("n", "<Leader>cn", ":DashboardNewFile<CR>")
map("n", "<Leader>fp", ":Telescope projects<cr>")
map("n", "<Leader>pu", ":PackerUpdate<cr>")
map("n", "<Leader>ss", ":e ~/.config/nvim/init.lua<cr>")
