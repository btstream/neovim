local manager = require("neo-tree.sources.manager")
local renderer = require("neo-tree.ui.renderer")
local command = require("neo-tree.command")

local SOURCE_POSITION_MAP = {
    filesystem = "left",
    buffers = "top",
    git_status = "right",
}

local function show(source, focus, position, dir)
    local cmd = {
        action = (focus == nil or focus) and "focus" or "show",
        source = source,
        toggle = true,
        position = position == nil and "left" or position,
    }

    if dir then
        cmd.dir = dir
    end
    command.execute(cmd)
end

local M = {}

--- get active source for neotree
--- if there is an active source, return source name and source index
--- if not, return nil
---@return table<string, number>
function M.get_active_sources()
    local active = {}
    if not require("neo-tree").config then
        return active
    end
    local sources = require("neo-tree").config.sources
    for i, s in pairs(sources) do
        if renderer.window_exists(manager.get_state(s)) then
            table.insert(active, s)
        end
    end
    return active
end

--- toggle neo tree sidebar
function M.toggle(focus, position, dir)
    local target_sources = vim.g.last_active_neotree_source or { "filesystem" }
    local active_sources = require("plugins.neo-tree.utils").get_active_sources()
    if #active_sources > 0 then
        target_sources = active_sources
        vim.g.last_active_neotree_source = active_sources
    end
    for _, source in pairs(target_sources) do
        local p = position or SOURCE_POSITION_MAP[source]
        show(source, focus, p, dir)
    end
end

return M
