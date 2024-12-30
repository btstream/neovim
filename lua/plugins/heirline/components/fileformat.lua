local separator = require("plugins.heirline.components.separator")

local format_icons = {
    dos = "",
    unix = "",
    mac = "",
}

local format_color = {
    dos = "blue",
    unix = "yellow",
    mac = "LightGrey"
}

local file_format = {
    provider = function()
        return " " .. format_icons[vim.bo[0].fileformat] .. " "
    end,
    hl = function()
        if require("settings").theme.statusline.show_separators then
            return { fg = format_color[vim.bo[0].fileformat] }
        end
    end,
}

local file_encoding = {
    provider = function()
        return vim.bo[0].fenc:upper() .. " "
    end,
    hl = function()
        if require("settings").theme.statusline.show_separators then
            return { fg = "LightGrey" }
        end
    end,
}

return {
    file_encoding,
    separator({ char = separator.left }),
    file_format,
    condition = function()
        return not require("utils.filetype").is_nonefiletype()
    end,
}
