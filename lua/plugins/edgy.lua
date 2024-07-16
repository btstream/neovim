local icons = require("themes.icons")

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.laststatus = 3
        vim.opt.splitkeep = "screen"
    end,
    opts = function()
        local opts = {
            top = {
                {
                    ft = "help",
                    size = { height = 0.3 },
                    -- only show help buffers
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
                { ft = "spectre_panel", title = "Search and Replace", size = { height = 0.3 } },
            },
            bottom = {
                -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
                {
                    ft = "toggleterm",
                    size = { height = 0.25 },
                    title = "%*%#ToggleTermTitle#"
                        .. icons.filetype_icons.toggleterm
                        .. "[%{b:toggle_number}]:%{b:term_title}",
                    -- exclude floating windows
                    filter = function(_, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                "Trouble",
                {
                    ft = "lazyterm",
                    title = "LazyTerm",
                    size = { height = 0.4 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
            },
            left = {
                -- Neo-tree filesystem always takes half the screen height
                {
                    -- reset title highlight group, as edgy use title in winbar, maybe reset to edgytitle after winbar update
                    title = "%*%#EdgyTitleNeoTreeFilesystem#" .. icons.common_ui_icons.file_explorer .. "  Filesystem",
                    ft = "neo-tree",
                    filter = function(buf)
                        -- filter out filesystem's source for current position, which is uesed for hijack netrw
                        return vim.b[buf].neo_tree_source == "filesystem" and vim.b[buf].neo_tree_position ~= "current"
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
        }

        for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
            opts[pos] = opts[pos] or {}
            table.insert(opts[pos], {
                ft = "trouble",
                filter = function(_buf, win)
                    if vim.w[win].trouble then
                        print(vim.inspect(vim.w[win].trouble))
                    end

                    return vim.w[win].trouble
                        and vim.w[win].trouble.position == pos
                        and vim.w[win].trouble.type == "split"
                        and vim.w[win].trouble.relative == "editor"
                        and not vim.w[win].trouble_preview
                end,
            })
        end

        return opts
    end,
}
