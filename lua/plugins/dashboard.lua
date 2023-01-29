return {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
        local function edit_config()
            vim.cmd("e " .. vim.fn.stdpath("config") .. "/" .. "init.lua")
        end

        local function version()
            local v = vim.version()
            return string.format("v%s.%s.%s%s", v.major, v.minor, v.patch, v.prerelease and "-dev" or "")
        end

        ----------------------------------------------------------------------
        --                        header and footer                         --
        ----------------------------------------------------------------------

        --- generate header
        local header = {
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
        }
        header = {
            "",
            "",
            "██████╗ ████████╗███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗",
            "██╔══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║",
            "██████╔╝   ██║   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║",
            "██╔══██╗   ██║   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║",
            "██████╔╝   ██║   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║",
            "╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝",
            "",
        }

        -- generate footer info
        local lazy_stats = require("lazy").stats()
        local footer = {
            "",
            string.format("🚀 version %s started in %sms", version(), lazy_stats.times.LazyDone),
            string.format("🧩 %s of %s plugins loaded", lazy_stats.loaded, lazy_stats.count),
        }

        ----------------------------------------------------------------------
        --                       config a hyper theme                       --
        ----------------------------------------------------------------------
        local hyper = {
            theme = "hyper",
            hide = {
                statusline = false, -- hide statusline default is true
                tabline = false, -- hide the tabline
                winbar = true, -- hide winbar
            },
            config = {
                header = header,
                shortcut = {
                    {
                        desc = "󰪶 Files",
                        group = "DashboardActionFiles",
                        action = "Telescope file_browser",
                        key = "b",
                    },
                    {
                        desc = " Colors",
                        group = "DashboardActionColors",
                        action = "Telescope colorscheme",
                        key = "t",
                    },
                    { desc = " Update", group = "DashboardActionUpdate", action = "Lazy update", key = "u" },
                    {
                        desc = " Settings",
                        group = "DashboardActionSettings",
                        key = "s",
                        action = "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua",
                    },
                },
                packages = { enable = false }, -- show how many plugins neovim loaded
                project = {
                    limit = 8,
                    icon = " ",
                    label = "Recently Projects",
                    action = "Telescope find_files cwd=",
                },
                mru = { limit = 10, icon = " ", label = "Recently Files" },
                footer = footer, -- footer
            },
        }

        require("dashboard").setup(hyper)

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
