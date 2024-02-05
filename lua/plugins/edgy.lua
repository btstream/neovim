local icons = require("themes.icons")

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
    opts = {
        bottom = {
            -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
            {
                ft = "toggleterm",
                size = { height = 0.25 },
                title = icons.filetype_icons.toggleterm .. "[%{b:toggle_number}]:%{b:term_title}",
                wo = {
                    winhighlight = "EdgyTitle:Comment",
                },
                -- exclude floating windows
                filter = function(buf, win)
                    return vim.api.nvim_win_get_config(win).relative == ""
                end,
            },
            {
                ft = "lazyterm",
                title = "LazyTerm",
                size = { height = 0.4 },
                filter = function(buf)
                    return not vim.b[buf].lazyterm_cmd
                end,
            },
            -- "Trouble",
            {
                ft = "help",
                size = { height = 20 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            { ft = "spectre_panel", size = { height = 0.4 } },
        },
        left = {
            -- Neo-tree filesystem always takes half the screen height
            {
                -- reset title highlight group, as edgy use title in winbar, maybe reset to edgytitle after winbar update
                title = "%*%#EdgyTitleNeoTreeFilesystem#" .. icons.common_ui_icons.file_explorer .. "  Filesystem",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                pinned = true,
                open = "Neotree position=left filesystem",
                size = { height = 0.5 },
            },
            {
                title = "%*%#EdgyTitleNeoTreeBuffers#" .. icons.common_ui_icons.buffers .. "  Buffers",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "buffers"
                end,
                pinned = true,
                open = "Neotree position=top buffers",
            },
            {
                title = "%*%#EdgyTitleNeoTreeGit#" .. icons.common_ui_icons.git .. "  Git",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "git_status"
                end,
                wo = {
                    winhighlight = "EdgyTitle:EdgyTitleNeoTreeGit",
                },
                pinned = true,
                open = "Neotree position=right git_status",
            },
        },
        right = {
            {
                title = "Outline",
                ft = "Outline",
                pinned = true,
                open = "Outline",
                wo = {
                    winbar = false,
                },
            },
        },

        ----------------------------------------------------------------------
        --                             options                              --
        ----------------------------------------------------------------------
        options = {
            left = { size = 45 },
            bottom = { size = 10 },
            right = { size = 45 },
            top = { size = 10 },
        },
        close_when_all_hidden = false,
        icons = {
            -- closed = " ",
            -- open = " ",
            closed = "",
            open = "",
        },
        wo = {
            winhighlight = "WinBar:EdgyWinBar,Normal:Normal",
        },
    },
}
