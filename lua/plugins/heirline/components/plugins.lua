local separator = require("plugins.heirline.components.separator")
local updates = {
    hl = function()
        if require("settings").theme.statusline.show_separators then
            return { bg = "grey", fg = "blue" }
        end
    end,
    provider = function(self)
        return "  " .. #require("lazy.manage.checker").updated .. " "
    end,
    on_click = {
        callback = require("utils.lazy").update_outdated,
        name = "statusline_update_plugins",
    },
}

local sp = separator({ char = separator.left })
sp.hl = { bg = "grey", fg = "LightGray" }
return {
    sp,
    updates,
    condition = require("lazy.status").has_updates,
    update = { "User", pattern = "LazyCheck" },
}
