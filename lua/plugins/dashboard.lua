return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
        local function edit_config()
            vim.cmd("e " .. vim.fn.stdpath("config") .. "/" .. "init.lua")
        end

        local dashboard = {
            theme = "doom",
            hide = {
                statusline = false, -- hide statusline default is true
                tabline = true, -- hide the tabline
                winbar = true, -- hide winbar
            },
            config = {},
        }

        local __header = {
            " ",
            " ",
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
            " ",
        }

        -- dashboard.hide_statusline = false -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
        -- dashboard.hide_tabline = false

        dashboard.config.header = __header
        dashboard.config.center = {
            {
                icon = "  ",
                desc = "Recently Opened Files" .. string.rep(" ", 20),
                key = "SPC f h",
                action = "Telescope oldfiles",
            },
            {
                icon = "  ",
                desc = "Open Project",
                key = "SPC f p",
                action = "Telescope projects",
            },
            {
                icon = "  ",
                desc = "Create New File",
                key = "SPC c n",
                action = "enew",
            },
            {
                icon = "  ",
                desc = "Find File",
                key = "SPC f f",
                action = "Telescope find_files",
            },
            {
                icon = "  ",
                desc = "Find Word",
                key = "SPC f w",
                action = "Telescope live_grep",
            },
            {
                icon = "  ",
                desc = "Choosehoose Colorscheme",
                key = "SPC t c",
                action = "Telescope colorscheme",
            },
            {
                icon = "  ",
                desc = "Configuration" .. string.rep("", 20),
                key = "SPC s s",
                action = "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua",
            },
        }

        require("dashboard").setup(dashboard)

        -- keymap
        local map = vim.keymap.set
        map("n", "<Leader>fh", "<cmd>Telescope oldfiles<CR>")
        map("n", "<Leader>ff", "<cmd>Telescope find_files<CR>")
        map("n", "<Leader>tc", "<cmd>Telescope colorscheme<CR>")
        map("n", "<Leader>fw", "<cmd>Telescope live_grep<CR>")
        map("n", "<Leader>cn", "<cmd>enew<CR>")
        map("n", "<Leader>fp", "<cmd>Telescope projects<cr>")
        map("n", "<Leader>ss", edit_config)
    end,
}
