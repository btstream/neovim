local manager = require("neo-tree.sources.manager")
local renderer = require("neo-tree.ui.renderer")

local M = {}

--- get active source for neotree
--- if there is an active source, return source name
--- if not, return nil
---@return string or nil
function M.get_active_source()
    local sources = require("neo-tree").config.sources
    local source = nil
    for _, s in pairs(sources) do
        if renderer.window_exists(manager.get_state(s)) then
            source = s
        end
    end
    return source
end

function M.get_active_source_label()
    local active_source = M.get_active_source()
    if active_source then
        return require("neo-tree").config.source_selector.tab_labels[active_source]
    end
end

function M.toggle() end

return M
