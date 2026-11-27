local icons = require("themes.icons")

--- Winbar metadata for a left pane that shares the combined title.
---@param key string matches `vim.g.sidebar_source`
---@param label string shown when the pane is active
---@param icon string shown in the winbar
---@param hl string highlight group for the icon
local function pane(key, label, icon, hl)
    return { key = key, label = label, icon = icon, hl = hl }
end

vim.g.sidebar_source = ""
vim.g.sidebar_type = ""
vim.g.sidebar_title = ""

local function get_title()
    return vim.g.sidebar_title
end

--- Left views that share the combined title, in config order. Membership is
--- decided by the view opts themselves (`sidebar` metadata + the shared title
--- getter), so adding or renaming a pane only touches `opts.left`.
local function titled_views()
    local layout = require("edgy.config").layout
    local eb = layout and layout.left
    local views = {}
    for _, view in ipairs(eb and eb.views or {}) do
        if view.sidebar and view.title == get_title then
            views[#views + 1] = view
        end
    end
    return views
end

local function indicator(view)
    return "%*%#" .. view.sidebar.hl .. "#" .. view.sidebar.icon .. " "
end

local function update_sidebar_title()
    local views = titled_views()
    if #views == 0 then
        return
    end

    local active = vim.g.sidebar_source
    local active_view
    local rest = {}
    for _, view in ipairs(views) do
        if view.sidebar.key == active then
            active_view = view
        else
            rest[#rest + 1] = view
        end
    end

    local parts = {}
    if active_view then
        -- the active pane leads with its label, then enough padding to push the
        -- remaining indicators to the right edge
        parts[1] = indicator(active_view) .. active_view.sidebar.label
        local width = 0
        if package.loaded.edgy then
            local sb = require("edgy.config").layout.left
            if sb and #sb.wins > 0 then
                width = sb.bounds.width
            end
        end
        parts[2] = string.rep(" ", math.max(width - #active_view.sidebar.label - 9, 0))
    end
    for _, view in ipairs(rest) do
        parts[#parts + 1] = indicator(view)
    end

    vim.g.sidebar_title = table.concat(parts)
end

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.splitkeep = "screen"
        -- Regions that show at most one edgy view at a time. The panes in each
        -- region are read from edgy's own config (each view's `ft` and
        -- `filter`), so a pane added to `opts` takes part automatically and
        -- nothing here knows about specific plugins. A view can opt out with
        -- `exclusive = false` in its own opts.
        local EXCLUSIVE = { "left", "bottom" }

        -- The edgebar for a position, or nil when edgy has not built it yet.
        local function edgebar(pos)
            local layout = require("edgy.config").layout
            local eb = layout and layout[pos]
            return eb and eb.views and eb or nil
        end

        -- The view that owns `buf` in `pos`, mirroring how edgy itself decides
        -- membership: same filetype, plus the view's filter when it has one.
        -- Views sharing a filetype (neo-tree's filesystem / buffers /
        -- git_status) are told apart by their filters, so they count as
        -- different panes without any hardcoded source names.
        local function view_for(pos, buf, win)
            local eb = edgebar(pos)
            if not eb then
                return nil
            end
            local ft = vim.bo[buf].filetype
            for _, view in ipairs(eb.views) do
                if view.exclusive ~= false
                    and view.ft == ft
                    and (not view.filter or (win ~= nil and view.filter(buf, win)))
                then
                    return view
                end
            end
            return nil
        end

        -- Cheap pre-check used at event time: does any exclusive-region view
        -- declare this buffer's filetype? Filters are ignored here on purpose,
        -- because they may read window variables that the plugin sets only
        -- after the window appears (snacks.nvim terminal does), so evaluating
        -- them this early would wrongly discard the event.
        local function candidate(buf)
            if not vim.api.nvim_buf_is_valid(buf) then
                return false
            end
            local ft = vim.bo[buf].filetype
            for _, pos in ipairs(EXCLUSIVE) do
                local eb = edgebar(pos)
                for _, view in ipairs(eb and eb.views or {}) do
                    if view.exclusive ~= false and view.ft == ft then
                        return true
                    end
                end
            end
            return false
        end

        -- Close every other window in `pos`, keeping only `keep_win`. The
        -- region is exclusive regardless of which view a window belongs to, so
        -- two windows of the same view (e.g. two terminals) also collapse to
        -- one.
        local function keep_only(pos, keep_win)
            local eb = edgebar(pos)
            -- iterate a copy: Win:close() removes itself from `eb.wins`, and
            -- mutating the list mid-loop would skip entries
            for _, entry in ipairs(vim.list_extend({}, eb and eb.wins or {})) do
                if entry.win ~= keep_win and vim.api.nvim_win_is_valid(entry.win) then
                    entry:close()
                end
            end
        end

        -- Enforce the exclusive regions for one window. Returns the set of
        -- regions the window belongs to.
        local function enforce(win, buf)
            local handled = {}
            if win == nil or win <= 0 or not vim.api.nvim_buf_is_valid(buf) then
                return handled
            end
            if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
                return handled
            end

            for _, pos in ipairs(EXCLUSIVE) do
                if view_for(pos, buf, win) then
                    handled[pos] = true
                    keep_only(pos, win)
                end
            end
            return handled
        end

        -- The title tracks only the panes that declare `sidebar` metadata, so
        -- the active one is recorded whenever one of them is entered. Both the
        -- key and the label come from that metadata, which keeps the winbar and
        -- the highlight group set in lua/themes/autocmds.lua in sync with
        -- `opts.left`.
        local function update_active_sidebar(win, buf)
            if win == nil or not vim.api.nvim_win_is_valid(win) then
                return
            end
            if not vim.api.nvim_buf_is_valid(buf) then
                return
            end

            local view = view_for("left", buf, win)
            if not view or not view.sidebar or view.title ~= get_title then
                return
            end

            vim.g.sidebar_type = view.ft
            vim.g.sidebar_source = view.sidebar.key
            update_sidebar_title()
        end

        local function enforce_and_track(win, buf)
            local handled = enforce(win, buf)
            if not handled.left then
                return false
            end
            update_active_sidebar(win, buf)
            return true
        end

        -- Deferred with `vim.schedule` so edgy has laid the new window out and
        -- the plugin has finished initialising the pane. The window that is
        -- focused at that moment wins, so a burst of panes opening in a row
        -- converges on the last one instead of closing a pane that was just
        -- opened; the event's own window is only pruned, never used for the
        -- title, since it may not be focused.
        local function on_layout_event(event)
            if not package.loaded.edgy then
                return
            end

            local buf = event.buf
            local win = event.win
            if win == nil or win <= 0 then
                win = vim.fn.bufwinid(buf)
                if win < 0 then
                    win = nil
                end
            end

            local cur_win = vim.api.nvim_get_current_win()
            local cur_buf = vim.api.nvim_win_get_buf(cur_win)
            if not (candidate(buf) or candidate(cur_buf)) then
                return
            end

            vim.schedule(function()
                if enforce_and_track(cur_win, cur_buf) then
                    return
                end
                enforce(win, buf)
            end)
        end

        -- Several triggers are needed because plugins differ in when the pane
        -- becomes recognisable: neo-tree sets the filetype before the window is
        -- shown, while outline.nvim focuses an existing window and assigns the
        -- filetype afterwards. All triggers funnel into the same idempotent
        -- pass, so extra events are harmless.
        vim.api.nvim_create_autocmd("BufWinEnter", { pattern = "*", callback = on_layout_event })
        vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", callback = on_layout_event })
        vim.api.nvim_create_autocmd("WinEnter", { pattern = "*", callback = on_layout_event })
        vim.api.nvim_create_autocmd("FileType", { pattern = "*", callback = on_layout_event })
    end,
    opts = function()
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
    end,
}
