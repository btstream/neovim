local separator = require("plugins.heirline.components.separator")
local shared = require("plugins.heirline.components.shared")
local checker = require("lazy.manage.checker")
local lazy_status = require("lazy.status")
local utils_lazy = require("utils.lazy")

local updates = {
    hl = function()
        if shared.show_separators() then
            return { bg = "grey", fg = "blue" }
        end
    end,
    provider = function()
        return "  " .. #checker.updated .. " "
    end,
    on_click = {
        callback = utils_lazy.update_outdated,
        name = "statusline_update_plugins",
    },
}

local sp = separator.make({ char = separator.left })
sp.hl = { bg = "grey", fg = "LightGray" }
return {
    sp,
    updates,
    condition = lazy_status.has_updates,
    update = { "User", pattern = "LazyCheck" },
}
