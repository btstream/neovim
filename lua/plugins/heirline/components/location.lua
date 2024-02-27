local icons = require("themes.icons").common_ui_icons
local mode_color = require("plugins.heirline.util").mode_color
local get_nonefiletype_icon = require("plugins.heirline.util").get_nonefiletype_icon

return {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,

    provider = function(self)
        local icon = get_nonefiletype_icon()
        if icon ~= nil then
            return " " .. icon .. " "
        end
        return " " .. icons.line_number .. "%2l:%2c "
    end,
    hl = mode_color,
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "CursorMoved", "CursorMovedI" },
}
