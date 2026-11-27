--- The combined left-sidebar winbar title.
---
--- Everything about the title is derived from the pane metadata (`M.pane`)
--- that the views declare in `plugins.edgy.views`, so this module owns no
--- pane names itself and nothing here knows about specific plugins.
local M = {}

--- Winbar metadata for a left pane that shares the combined title.
---@param key string matches `vim.g.sidebar_source`
---@param label string shown when the pane is active
---@param icon string shown in the winbar
---@param hl string highlight group for the icon
function M.pane(key, label, icon, hl)
    return { key = key, label = label, icon = icon, hl = hl }
end

vim.g.sidebar_source = ""
vim.g.sidebar_type = ""
vim.g.sidebar_title = ""

--- The winbar entry point: every pane that shares the combined title uses
--- this as its edgy `title`.
function M.get_title()
    return vim.g.sidebar_title
end

--- Left views that share the combined title, in config order. Membership is
--- decided by the view opts themselves (`sidebar` metadata + the shared title
--- getter), so adding or renaming a pane only touches `plugins.edgy.views`.
--- Empty before edgy has been loaded and set up.
local function titled_views()
    if not package.loaded.edgy then
        return {}
    end
    local layout = require("edgy.config").layout
    local eb = layout and layout.left
    local views = {}
    for _, view in ipairs(eb and eb.views or {}) do
        if view.sidebar and view.title == M.get_title then
            views[#views + 1] = view
        end
    end
    return views
end

local function indicator(view)
    return "%*%#" .. view.sidebar.hl .. "#" .. view.sidebar.icon .. " "
end

--- Redraw the title: the active pane leads with its label, then enough
--- padding to push the remaining indicators to the right edge.
function M.update()
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
        parts[1] = indicator(active_view) .. active_view.sidebar.label
        local width = 0
        local sb = require("edgy.config").layout.left
        if sb and #sb.wins > 0 then
            width = sb.bounds.width
        end
        parts[2] = string.rep(" ", math.max(width - #active_view.sidebar.label - 9, 0))
    end
    for _, view in ipairs(rest) do
        parts[#parts + 1] = indicator(view)
    end

    vim.g.sidebar_title = table.concat(parts)
end

--- Record `view` as the pane currently shown in the sidebar.
---
--- `vim.g.sidebar_source` keeps matching the keys declared with `M.pane`,
--- which is what lua/themes/autocmds.lua reads for highlighting.
function M.set_active(view)
    vim.g.sidebar_type = view.ft
    vim.g.sidebar_source = view.sidebar.key
    M.update()
end

--- The pane highlight groups as `key -> hl`, derived from the same metadata
--- that renders the title. Empty before edgy has been loaded and set up.
function M.groups()
    local groups = {}
    for _, view in ipairs(titled_views()) do
        groups[view.sidebar.key] = view.sidebar.hl
    end
    return groups
end

return M
