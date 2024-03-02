local separator = require("plugins.heirline.components.separator")

local format_icons = {
    dos = "",
    unix = "",
    mac = "",
}

local file_format = {
    provider = function()
        return " " .. format_icons[vim.bo[0].fileformat] .. " "
    end,
}

local file_encoding = {
    provider = function()
        return vim.bo[0].fenc:upper() .. " "
    end,
}

return {
    file_encoding,
    separator({ char = separator.left }),
    file_format,
    hl = function()
        return { fg = require("themes.colors.manager").get_named_color("LightGrey") }
    end,
    condition = function()
        return not require("utils.filetype").is_nonefiletype()
    end,
}
