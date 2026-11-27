local separator = require("plugins.heirline.components.separator")
local shared = require("plugins.heirline.components.shared")

local format_icons = {
    dos = "",
    unix = "",
    mac = "",
}

local format_color = {
    dos = "blue",
    unix = "yellow",
    mac = "LightGrey",
}

local file_format = {
    provider = function()
        return " " .. format_icons[vim.bo.fileformat] .. " "
    end,
    hl = function()
        if shared.show_separators() then
            return { fg = format_color[vim.bo.fileformat] }
        end
    end,
}

local file_encoding = {
    provider = function()
        return vim.bo.fenc:upper() .. " "
    end,
    hl = function()
        if shared.show_separators() then
            return { fg = "LightGrey" }
        end
    end,
}

return {
    file_encoding,
    separator.make({ char = separator.left }),
    file_format,
    condition = function()
        return not shared.is_nonefiletype()
    end,
}
