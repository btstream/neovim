-- extend filename section to indicate dashboards/terminals and other things
local filename = require("lualine.components.filename"):extend()
local filetype_tools = require("plugins.settings.statusline.lualine.utils.filetype_tools")

-- override
function filename:update_status(is_focused)
    local b, t = filetype_tools.is_nonefiletype()
    if b and t ~= "HELP" then
        return ""
    end

    return filename.super.update_status(self, is_focused)
end

return filename
