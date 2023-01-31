local M = {}

function M.update()
    local plugins = require("lazy.core.config").plugins
    local outdated = {}
    for name, p in pairs(plugins) do
        if p._.updates ~= nil then
            table.insert(outdated, name)
        end
    end

    if #outdated > 0 then
        require("lazy")
            .update({
                plugins = outdated,
                show = false,
            })
            :wait(function()
                vim.notify(
                    string.format("These plugins has been updated: \n%s", table.concat(outdated, "\n")),
                    vim.log.levels.INFO,
                    { title = "Plugins Manager" }
                )
            end)
    end
end

return M
