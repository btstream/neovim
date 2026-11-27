-- Filetype icon of the current buffer (devicons, with fallbacks)
local devicons = require("nvim-web-devicons")
local icons = require("themes.icons").common_ui_icons
local shared = require("plugins.heirline.components.shared")

return {
    init = function(self)
        local filename = vim.api.nvim_buf_get_name(0)
        local ext = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_colors = devicons.get_icon_color(filename, ext)
        self.icon = self.icon or icons.file_common
        if filename == "" then
            self.icon = icons.file_new
        end
    end,
    provider = function(self)
        return " " .. self.icon .. ""
    end,
    hl = function(self)
        return { fg = self.icon_colors }
    end,
    condition = function()
        return not shared.is_nonefiletype()
    end,
}
