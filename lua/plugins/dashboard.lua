return {
    "glepnir/dashboard-nvim",
    event = "User LazyVimStarted",
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
        local header = require("settings").banner and require("settings").banner
            or {
                "",
                "                                                 🐀 🐅 🐖 🐓 To Taotao",
                "   ██████╗ ████████╗███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗",
                "   ██╔══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║",
                "   ██████╔╝   ██║   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║",
                "   ██╔══██╗   ██║   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║",
                "   ██████╔╝   ██║   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║",
                "   ╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝",
            }

        -- generate footer info
        local lazy_stats = require("lazy").stats()
        local footer = {
            "",
            string.format("🚀 version %s started in %.2fms", version(), lazy_stats.startuptime),
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
                        key = "o",
                    },
                    {
                        desc = " New",
                        group = "DashboardActionNew",
                        action = "enew",
                        key = "n",
                    },
                    {
                        desc = " Colors",
                        group = "DashboardActionColors",
                        action = "Telescope colorscheme",
                        key = "t",
                    },
                    {
                        desc = " Update",
                        group = "DashboardActionUpdate",
                        action = require("utils.lazy").update,
                        key = "u",
                    },
                    {
                        desc = " Settings",
                        group = "DashboardActionSettings",
                        key = "s",
                        action = "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua",
                    },
                },
                packages = { enable = false }, -- show how many plugins neovim loaded
                project = {
                    limit = 5,
                    icon = " ",
                    label = "Recently Projects",
                    action = "Telescope find_files cwd=",
                },
                mru = { limit = 8, icon = " ", label = "Recently Files" },
                footer = footer, -- footer
            },
        }

        require("dashboard").setup(hyper)

        if vim.fn.argc() == 0 and vim.fn.line2byte("$") == -1 then
            require("dashboard"):instance()
        end

        --stylua: ignore
        -- require("utils.keymap_tools").map({
        --     { "n", "<Leader>fh", "<cmd>Telescope oldfiles<CR>"   , { desc = "Open file history" } }     ,
        --     { "n", "<Leader>ff", "<cmd>Telescope find_files<CR>" , { desc = "Find files in cwd" } }     ,
        --     { "n", "<Leader>tc", "<cmd>Telescope colorscheme<CR>", { desc = "Change colorscheme" } }    ,
        --     { "n", "<Leader>fw", "<cmd>Telescope live_grep<CR>"  , { desc = "Find word in workspace" } },
        --     { "n", "<Leader>cn", "<cmd>enew<CR>"                 , { desc = "Create new file" } }       ,
        --     { "n", "<Leader>fp", "<cmd>Telescope projects<cr>"   , { desc = "Project history" } }       ,
        --     { "n", "<Leader>ss", edit_config                     , { desc = "Open Settings" } }         ,
        -- })
    end,
}
