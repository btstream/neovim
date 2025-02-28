local icons = require("themes.icons").common_ui_icons
return {
    width = 70,
    preset = {
        keys = {
            { icon = icons.folder .. " ", key = "o", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = icons.file_new .. " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = icons.history .. " ", key = "h", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = icons.settings .. " ", key = "s", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        -- Used by the `header` section
        header = [[
🐀 🐅 🐖 🐓 To Taotao, by
██████╗ ████████╗███████╗████████╗██████╗ ███████╗ █████╗ ███╗   ███╗
██╔══██╗╚══██╔══╝██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗ ████║
██████╔╝   ██║   ███████╗   ██║   ██████╔╝█████╗  ███████║██╔████╔██║
██╔══██╗   ██║   ╚════██║   ██║   ██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║
██████╔╝   ██║   ███████║   ██║   ██║  ██║███████╗██║  ██║██║ ╚═╝ ██║
╚═════╝    ╚═╝   ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
                                                    powered by neovim
        ]]
    },
    sections = {
        { section = "header", padding = 1 },
        { icon = " ", title = "Menu", section = "keys", indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", limit = 8, indent = 2, padding = 1 },
        { pane = 2, icon = " ", title = "Projects", section = "projects", limit = 8, indent = 2, padding = 1 },
        { section = "startup", padding = 1 },
    }
}
