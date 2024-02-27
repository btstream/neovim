local nonefiletypes = require("utils.filetype_tools").get_nonfiletypes()

-- stylua: ignore start
local comman_color_base16_map = {
    red                       = "base0F",
    DarkRed                   = "base08",
    green                     = "base0B",
    blue                      = "base0D",
    gray                      = "base01",
    grey                      = "base02",
    LightGray                 = "base03",
    LightGrey                 = "base04",
    white                     = "base07",
    GhostWhite                = "base06",
    WhiteSmoke                = "base05",
    yellow                    = "base0A",
    orange                    = "base09",
    purple                    = "base0E",
    cyan                      = "base0C",
    black                     = "base00",
}

local mode_colors_map = {
    n                 = "blue",
    i                 = "green",
    v                 = "purple",
    V                 = "purple",
    ["\22"]           = "cyan",
    c                 = "blue",
    s                 = "yellow",
    S                 = "yellow",
    ["\19"]           = "purple",
    R                 = "orange",
    r                 = "orange",
    ["!"]             = "DarkRed",
    t                 = "green",
}
-- stylua: ignore end

local M = {}

function M.get_color(name)
    if comman_color_base16_map[name] then
        return require("themes.base16.colors").colors()[comman_color_base16_map[name]]
    end
    return name
end

function M.mode_color(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    local colors = require("themes.base16.colors").colors()
    local bg, fg = mode_colors_map[mode], "black"
    if colors then
        bg, fg = colors[comman_color_base16_map[bg]], colors[comman_color_base16_map[fg]]
    end
    return { bg = bg, fg = fg }
end

function M.get_nonefiletype_icon()
    local ft = vim.bo.filetype
    if vim.tbl_contains(nonefiletypes, ft) then
        return require("themes.icons").filetype_icons[ft]
    end
end

return M
