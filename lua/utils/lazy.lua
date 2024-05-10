local M = {}

function M.update_outdated()
    local plugins = require("lazy.core.config").plugins
    local outdated = {}
    for name, p in pairs(plugins) do
        if p._.updates ~= nil then
            table.insert(outdated, name)
        end
    end

    if #outdated > 0 then
        require("lazy").update({
            plugins = outdated,
            concurrency = 2,
            show = true,
        })
    end
end

return M
