local M = {}

function M.update()
    local plugins = require("lazy.core.config").plugins
    local outdated = {}
    for _, p in pairs(plugins) do
        if p._.updates ~= nil then
            table.insert(outdated, p)
        end
    end

    if #outdated > 0 then
        require("lazy").update({
            plugins = outdated,
            show = false,
        })
    end
end

return M
