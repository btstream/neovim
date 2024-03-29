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
    local sources = require("neo-tree").config.sources
    local active = {}
    for i, s in pairs(sources) do
        if renderer.window_exists(manager.get_state(s)) then
            table.insert(active, s)
        end
    end
    return active
end

--- get active sources label, used in lualine
---@return string | nil
-- function M.get_active_source_label()
--     local active_source = M.get_active_source()
--     if active_source then
--         return require("neo-tree").config[active_source].display_name
--     end
--     return nil
-- end

--- navigate to source
---@param index number
-- function M.goto_source(index)
--     local sources = require("neo-tree").config.sources
--     local i = index % #sources == 0 and #sources or index
--     local source = sources[i]
--     if source ~= M.get_active_source() then
--         show(source)
--     end
-- end

--- goto next source
-- function M.goto_next_source()
--     local _, index = M.get_active_source()
--     M.goto_source(index + 1)
-- end

--- goto previous source
-- function M.goto_previous_source()
--     local _, index = M.get_active_source()
--     if index - 1 < 1 then
--         index = #require("neo-tree").config.sources
--     else
--         index = index - 1
--     end
--     M.goto_source(index)
-- end

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
