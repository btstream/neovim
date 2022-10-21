-- local darken = require("themes.utils").darken
-- local highlight = require("themes.utils").highlight

local function get_base16_colors(scheme)
    local style = scheme and scheme
    if scheme == nil then
        if vim.g.colors_name == nil then
            style = require("settings").theme.base16_style
        else
            local b, p = vim.g.colors_name:find("base16")
            if b then
                style = vim.g.colors_name:sub(p + 2)
                print(style)
            else
                style = require("settings").theme.base16_style
            end
        end
    end
    local colors = require("base16-colorscheme").colorschemes[style]
    return colors
end

return {
    colors = get_base16_colors,
}
