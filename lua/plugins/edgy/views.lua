--- The edgy layout: which panes exist on each side, their sizes, and the
--- buffer-local keys. Adding a pane means adding an entry here; the winbar
--- title (plugins.edgy.title) and the single-pane rule
--- (plugins.edgy.exclusive) pick it up automatically.
local icons = require("themes.icons")
local title = require("plugins.edgy.title")

local get_title = title.get_title
local pane = title.pane

local M = {}

---@return table edgy opts
function M.build()
    local opts = {
        animate = {
            enabled = false,
        },
        top = {
            {
                ft = "help",
                size = { height = 0.5 },
                -- only show help buffers
                filter = function(buf)
                    return vim.bo[buf].buftype == "help"
                end,
            },
            { ft = "spectre_panel", title = "Search and Replace", size = { height = 0.3 } },
        },
        bottom = {
            {
                ft = "snacks_terminal",
                size = { height = 0.25 },
                title = "%*%#ToggleTermTitle#"
                    .. icons.filetype_icons.terminal
                    .. " %{b:snacks_terminal.id}: %{b:term_title}",
                -- exclude floating windows
                filter = function(_, win)
                    return vim.w[win].snacks_win
                        and vim.w[win].snacks_win.position == "bottom"
                        and vim.w[win].snacks_win.relative == "editor"
                        and not vim.w[win].trouble_preview
                end,
            }
        },
        left = {
            -- Neo-tree filesystem always takes half the screen height
            {
                title = get_title,
                ft = "neo-tree",
                filter = function(buf)
                    -- filter out filesystem's source for current position, which is uesed for hijack netrw
                    return vim.b[buf].neo_tree_source == "filesystem" and vim.b[buf].neo_tree_position ~= "current"
                end,
                sidebar = pane(
                    "filesystem",
                    "Filesystem",
                    icons.common_ui_icons.file_explorer,
                    "EdgyTitleNeoTreeFilesystem"
                ),
                open = "Neotree position=left filesystem",
                size = { height = 0.5 },
            },
            {
                title = get_title,
                ft = "Outline",
                -- pinned = true,
                sidebar = pane("outline", "Outline", icons.common_ui_icons.symbols_outlne, "EdgyTitleOutline"),
                open = "Outline",
            },
            {
                title = get_title,
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "buffers"
                end,
                sidebar = pane("buffers", "Buffers", icons.common_ui_icons.buffers, "EdgyTitleNeoTreeBuffers"),
                -- pinned = true,
                open = "Neotree position=top buffers",
            },
            {
                title = get_title,
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "git_status"
                end,
                sidebar = pane("git_status", "Git Status", icons.common_ui_icons.git, "EdgyTitleNeoTreeGit"),
                wo = {
                    winhighlight = "EdgyTitle:EdgyTitleNeoTreeGit",
                },
                -- pinned = true,
                open = "Neotree position=right git_status",
            },
        },
        right = {
            {
                title = "Chat",
                ft = "opencode_terminal",
            },
            {
                title = "Chat",
                ft = "opencode_output",
            },
            {
                title = "Conversation",
                ft = "opencode",
                size = {
                    height = 0.2
                }
            }
        },

        ----------------------------------------------------------------------
        --                             options                              --
        ----------------------------------------------------------------------
        options = {
            left = { size = 45 },
            bottom = { size = 10 },
            right = { size = 55 },
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
            winfixwidth = false,
            winhighlight = "WinBar:EdgyWinBar,Normal:Normal",
        },
        -- Resize keys, aligned with the global <C-S-Arrow> mappings in
        -- lua/base/keymap.lua so the same keys resize a window everywhere.
        -- edgy deep-merges this table with its defaults, so the old
        -- <C-w>> / <C-w>< / <C-w>+ / <C-w>- bindings must be set to false
        -- explicitly to turn them off.
        keys = {
            ["<c-w>>"] = false,
            ["<c-w><lt>"] = false,
            ["<c-w>+"] = false,
            ["<c-w>-"] = false,
            -- increase width
            ["<C-M-Right>"] = function(win)
                win:resize("width", 2)
            end,
            -- decrease width
            ["<C-M-Left>"] = function(win)
                win:resize("width", -2)
            end,
            -- increase height
            ["<C-M-Up>"] = function(win)
                win:resize("height", 2)
            end,
            -- decrease height
            ["<C-M-Down>"] = function(win)
                win:resize("height", -2)
            end,
            -- reset all custom sizing
            ["<C-w>="] = function(win)
                win.view.edgebar:equalize()
            end,
        },
    }
    require("ade.integrations.edgy").extend(opts, {
        team = { tree = "left", members = "left", board = "bottom" },
    })
    return opts
end

return M
