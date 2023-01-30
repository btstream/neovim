local color_scheme = nil
local function get_color_scheme(scheme)
    local style = scheme and scheme
    if scheme == nil then
        if vim.g.colors_name == nil then
            style = require("settings").theme.base16_style
        else
            local b, s = vim.g.colors_name:find("base16")
            if b then
                style = vim.g.colors_name:sub(s + 2)
            else
                style = require("settings").theme.base16_style
            end
        end
    end
    local ret = require("base16-colorscheme").colorschemes[style]
    return ret
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        color_scheme = get_color_scheme()
    end,
})

local function colors(scheme)
    if scheme ~= nil then
        return get_color_scheme(scheme)
    end

    if color_scheme == nil then
        color_scheme = get_color_scheme()
    end

    return color_scheme
end

return {
    colors = colors,
}
