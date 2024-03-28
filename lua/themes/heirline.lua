local M = {}


-- stylua: ignore start
local mode_colors = {
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
    r                 = "blue",
    ["!"]             = "DarkRed",
    t                 = "green",
}
-- style: ignore end

function M.get_heirline_color()
    local colors = require("themes.colors.manager").colors()
    
    -- stylua: ignore start
    return {
        red        = colors.base0F,
        DarkRed    = colors.base08,
        green      = colors.base0B,
        blue       = colors.base0D,
        gray       = colors.base01,
        grey       = colors.base02,
        LightGray  = colors.base03,
        LightGrey  = colors.base04,
        white      = colors.base07,
        GhostWhite = colors.base06,
        WhiteSmoke = colors.base05,
        yellow     = colors.base0A,
        orange     = colors.base09,
        purple     = colors.base0E,
        cyan       = colors.base0C,
        black      = colors.base00,
    }
    -- stylua: ignore end
end

function M.get_mode_color(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    local bg, fg = mode_colors[mode], "black"
    return { bg = bg, fg = fg }

end

return M
