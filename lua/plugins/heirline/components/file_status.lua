-- modified / readonly / suda markers
local icons = require("themes.icons").common_ui_icons
local shared = require("plugins.heirline.components.shared")

local function is_readonly()
    return vim.bo.modifiable == false or vim.bo.readonly == true
end

return {
    provider = function(self)
        if vim.bo.modified then
            return " " .. icons.file_modified .. " "
        end

        if is_readonly() then
            return " " .. icons.file_readonly .. " "
        end

        if self.filename:match("^suda://") then
            return " " .. icons.file_readonly .. " "
        end
        return " "
    end,
    condition = function()
        return not shared.is_nonefiletype()
    end,
    hl = function(self)
        if vim.bo.modified then
            return { fg = "green" }
        end

        if is_readonly() then
            return { fg = "orange" }
        end

        if self.filename:match("^suda://") then
            return { fg = "red" }
        end
    end,
}
