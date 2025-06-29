return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- dir = "/home/lzc/Development/projects_for_opensource/snacks.nvim",
    -- dev = true,
    formatters = {
        file = {
            truncate = 25,
            icon_width = 4,
        },
    },
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        input = { enabled = true },
        dashboard = require("plugins.snacks.dashboard"),
        -- explorer = { enabled = true },
        indent = require("plugins.snacks.indent"),
        -- input = { enabled = true },
        picker = require("plugins.snacks.picker"),
        terminal = require("plugins.snacks.terminal"),
        notifier = { enabled = true },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        lazygit = require("plugins.snacks.lazygit")
        -- statuscolumn = { enabled = true },
        -- words = { enabled = true },
    },
    keys = require("plugins.snacks.keys")
}
