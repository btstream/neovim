local devicons = require("nvim-web-devicons")

local icons = require("themes.icons").common_ui_icons
local is_nonefiletype = require("utils.filetype_tools").is_nonefiletype
local get_color = require("plugins.heirline.util").get_color

local file_icons = {
    init = function(self)
        local filename = self.filename
        local ext = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_colors = devicons.get_icon_color(filename, ext)
        self.icon = self.icon or " "
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
            if ft == "toggleterm" then
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
            return { fg = get_color("green") }
        end

        if vim.bo.modifiable == false or vim.bo.readonly == true then
            return { fg = get_color("orange") }
        end

        if self.filename:match("^suda://") then
            return { fg = get_color("red") }
        end
    end,
}

local update_count = 1
return {
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
        self.ft = vim.bo.filetype
        update_count = update_count + 1
    end,
    hl = function()
        return { bg = get_color("grey") }
    end,
    file_icons,
    file_name,
    file_status,
    update = { "WinEnter", "BufEnter", "BufAdd", "BufWinLeave", "WinClosed", "BufModifiedSet" },
}
