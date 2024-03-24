local icons = require("themes.icons").common_ui_icons
local get_nonefiletype_icon = require("utils.filetype").get_icon
local is_nonefiletype = require("utils.filetype").is_nonefiletype
local get_mode_color = require("themes.heirline").get_mode_color
local settings = require("settings")

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
    hl = function(self)
        if settings.theme.statusline.show_separators == true or is_nonefiletype() then
            return get_mode_color(self)
        end
    end,
    update = { "ModeChanged", "WinEnter", "BufEnter", "BufWinLeave", "CursorMoved", "CursorMovedI" },
}
