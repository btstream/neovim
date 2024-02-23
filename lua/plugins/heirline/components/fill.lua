return {
    provider = "%=",
    hl = function()
        local colors = require("themes.base16.colors").colors()
        return { bg = colors.base01, fg = colors.base01 }
    end,
    update = "ColorScheme",
}
