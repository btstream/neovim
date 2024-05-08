return {
    hl = function()
        if require("settings").theme.statusline.show_separators then
            return { bg = "grey" }
        end
    end,
    provider = function(self)
        return " " .. require("lazy.status").updates()
    end,
    condition = require("lazy.status").has_updates,
    update = { "User", pattern = "LazyCheck" },
    on_click = {
        callback = function()
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
        end,
        name = "statusline_update_plugins",
    },
    -- update = { "LspAttach", "LspDetach", "WinEnter", "BufEnter", "BufLeave", "WinLeave" },
}
