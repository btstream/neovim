local icons = require("themes.icons").common_ui_icons
local get_nonefiletype_icon = require("utils.filetype").get_icon
local get_mode_color = require("themes.colors.manager").get_mode_color

return {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,

    provider = function(self)
        local icon = get_nonefiletype_icon()
        if icon ~= nil then
            return " " .. icon .. " "
        end
        return " " .. icons.line_number .. " %2l:%2c "
    end,
    hl = get_mode_color,
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "CursorMoved", "CursorMovedI" },
}
