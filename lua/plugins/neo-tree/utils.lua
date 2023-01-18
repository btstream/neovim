local manager = require("neo-tree.sources.manager")
local renderer = require("neo-tree.ui.renderer")

local M = {}

--- get active source for neotree
--- if there is an active source, return source name and source index
--- if not, return nil
---@return string, number or nil, nil
function M.get_active_source()
    local sources = require("neo-tree").config.sources
    local source = nil
    local index = -1
    for i, s in pairs(sources) do
        if renderer.window_exists(manager.get_state(s)) then
            source = s
            index = i
        end
    end
    return source, index
end

function M.get_active_source_label()
    local active_source = M.get_active_source()
    if active_source then
        return require("neo-tree").config.source_selector.tab_labels[active_source]
    end
end

function M.toggle(index)
    local sources = require("neo-tree").config.sources
    local i = index % #sources == 0 and 1 or index
    local source = sources[i]
    if source ~= M.get_active_source() then
        require("neo-tree").focus(source, true, true)
    end
end

function M.toggle_next()
    local _, index = M.get_active_source()
    M.toggle(index + 1)
end

function M.toggle_previous()
    local _, index = M.get_active_source()
    if index - 1 < 1 then
        index = #require("neo-tree").config.sources
    else
        index = index - 1
    end
    M.toggle(index)
end

return M
