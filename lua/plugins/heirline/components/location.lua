local icons = require("themes.icons").common_ui_icons
local get_mode_color = require("themes.heirline").get_mode_color
local shared = require("plugins.heirline.components.shared")

return {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,

    provider = function(self)
        local icon = shared.get_nonefiletype_icon()
        if icon ~= nil then
            return " " .. icon .. " "
        end
        return " " .. icons.line_number .. " %2l:%2c "
    end,
    hl = function(self)
        if shared.show_separators() == true or shared.is_nonefiletype() then
            return get_mode_color(self)
        end
    end,
    update = shared.update.location,
}
