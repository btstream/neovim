local icons = require("themes.icons").common_ui_icons
return {
    "glepnir/dashboard-nvim",
    event = "User LazyVimStarted",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
        ----------------------------------------------------------------------
        --                        header and footer                         --
        ----------------------------------------------------------------------

        --- generate header
        -- local header = {
        --     " ",
        --     "      ╦           ┐                                                                                ",
        --     "   ╓▒╠╠▒╕        ╒╣▓╕                                                                              ",
        --     " ╓╣╬╬╬╠╠╠▒        ╣╣╣▓▄                                                     ╫██─                   ",
        --     "╒▒▒╠╬╬╬╠╠╠▒       ╣╣╣╣╣▌                                                                           ",
        --     "╒╠╠╠╠╣╬╠╠╠╠╠▒     ╣╣╣╣╣▌      ▐▌╓╧▀╙╙▀▄    ▄▀▀╙╙╙╗    ╓▌▀╙╙▀▀▄  ██▓     ▓██ ╟██─ ╟██▓████▓▄▓█████▌ ",
        --     "╒╠╠╠╠╠▒╣╠╠╠╠╠▒    ▓▓▓▓▓▌      ║█      ║▌  ▓─      ║╕ ▓▀      └█ ╙██▌   ╟██─ ╟██─ ╟██╩   ║██▌   ║██▌",
        --     "▐╠╠╠╠╠░ ╚╠╠╠╠╠╬╕  ▓▓▓▓▓▌      ║▌       █ ▐█╙╙╙╙╙╙╙▀▀ █        ╫▌ ╙██▄ ╔██╛  ╟██─ ╟██    ║██▌   ╒██▌",
        --     "▐╠╠╠╠╠▒  └╣╬╬╬╬╬▒╓▓▓▓▓▓▌      ║▌       █ └█          █        ▓▌  ╚██╗██▀   ╟██─ ╟██    ║██▌   ╒██▌",
        --     "▐╠╠╠╠╠▒    ╚╬╬╬╬╬╣▓▓▓▓▓▌      ║▌       █  ╙▓      ╓  ╙▓      ▄▀    ║███▀    ╟██─ ╟██    ║██▌   ╒██▌",
        --     "▐╠╠╠╠╠▒     └╣╬╬╬╣▓▓█▓▓▌      ╙└       ▀    └╙▀▀╙╙     └╙╙╙▀╙       ╙╙╙     ╙╙╙  ╙╙╙    └╙╙     ╙╙└",
        --     " ╩╬╬╬╬▒       ║╬╬╣▓▓▓██╙                                                                           ",
        --     "   ╚╬╬▒        ╙╣╣▓▓▓╙                                                                             ",
        --     "     ╙▒          ╣▀└                                                                               ",
        -- }
        local function banner()
            local version = " driven by " .. vim.split(vim.api.nvim_exec2("version", { output = true }).output, "\n")[2]
            local ret = {
                "",
                "   🐀 🐅 🐖 🐓 To Taotao, by",
                "   ██████╗ ████████╗███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗",
                "   ██╔══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║",
                "   ██████╔╝   ██║   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║",
                "   ██╔══██╗   ██║   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║",
                "   ██████╔╝   ██║   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║",
                "   ╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝",
            }
            table.insert(ret, version)
            table.insert(ret, "")
            return ret
        end
        local header = require("settings").banner and require("settings").banner or banner()

        -- generate footer info
        local lazy_stats = require("lazy").stats()
        local footer = {
            "",
            string.format("🚀 started in %.2fms", lazy_stats.startuptime)
                .. string.format(", with %s of %s plugins loaded", lazy_stats.loaded, lazy_stats.count),
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
                        desc = icons.folder .. " Files",
                        group = "DashboardActionFiles",
                        action = "Telescope file_browser",
                        key = "o",
                    },
                    {
                        desc = icons.file_new .. " New",
                        group = "DashboardActionNew",
                        action = "enew",
                        key = "n",
                    },
                    {
                        desc = icons.history .. " History",
                        group = "DashboardActionHistory",
                        action = "Telescope oldfiles",
                        key = "h",
                    },
                    {
                        desc = icons.colors .. " Colors",
                        group = "DashboardActionColors",
                        action = "Telescope colorscheme",
                        key = "t",
                    },
                    {
                        desc = icons.update .. " Update",
                        group = "DashboardActionUpdate",
                        action = require("utils.lazy").update,
                        key = "u",
                    },
                    {
                        desc = icons.settings .. " Settings",
                        group = "DashboardActionSettings",
                        key = "s",
                        action = "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua",
                    },
                },
                packages = { enable = false }, -- show how many plugins neovim loaded
                project = {
                    limit = 5,
                    icon = icons.project .. " ",
                    label = "Recently Projects",
                    action = "Telescope find_files cwd=",
                },
                mru = { limit = 8, icon = icons.file_common .. " ", label = "Recently Files" },
                footer = footer, -- footer
            },
        }

        require("dashboard").setup(hyper)

        if vim.fn.argc() == 0 and vim.fn.line2byte(vim.fn.line("$")) == -1 then
            require("dashboard"):instance()
        end
    end,
}
