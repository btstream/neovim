local devicons = require("nvim-web-devicons")

local icons = require("themes.icons").common_ui_icons
local is_nonefiletype = require("utils.filetype").is_nonefiletype

local file_icons = {
    init = function(self)
        local filename = self.filename
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
        return not is_nonefiletype()
    end,
}

local file_name = {
    provider = function(self)
        local flag, ft = is_nonefiletype()
        if flag then
            -- do not show filetypename for terminal
            if ft == "toggleterm" or ft == "terminal" then
                return ""
            end
            return " " .. ft .. " "
        elseif #self.filename == 0 then
            return " [No Name]"
        else
            return " " .. vim.fn.fnamemodify(self.filename, ":t")
        end
    end,
}

local file_status = {
    provider = function(self)
        if vim.bo.modified then
            return " " .. icons.file_modified .. " "
        end

        if vim.bo.modifiable == false or vim.bo.readonly == true then
            return " " .. icons.file_readonly .. " "
        end

        if self.filename:match("^suda://") then
            return " " .. icons.file_readonly .. " "
        end
        return " "
    end,
    condition = function()
        return not is_nonefiletype()
    end,
    hl = function(self)
        if vim.bo.modified then
            return { fg = "green" }
        end

        if vim.bo.modifiable == false or vim.bo.readonly == true then
            return { fg = "orange" }
        end

        if self.filename:match("^suda://") then
            return { fg = "red" }
        end
    end,
}

local sep = require("plugins.heirline.components.separator")
local separator = sep({
    char = sep.right_block,
    block = true,
})
separator.condition = function()
    local _, ft = is_nonefiletype()
    return ft ~= "toggleterm"
end

return {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.ft = vim.bo.filetype
    end,
    hl = function()
        if require("settings").theme.statusline.show_separators then
            return { bg = "grey" }
        end
    end,
    file_icons,
    file_name,
    file_status,
    separator,
    update = { "WinEnter", "BufEnter", "BufAdd", "BufWinLeave", "WinClosed", "BufModifiedSet" },
}
