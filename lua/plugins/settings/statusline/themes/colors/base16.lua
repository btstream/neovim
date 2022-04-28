local colors = require("base16-colorscheme").colorschemes
local name_scheme = {
    bg = "base01",
    fg = "base04",
    red = "base08",
    orange = "base09",
    yellow = "base0A",
    green = "base0B",
    blue = "base0D",
    cyan = "base0C",
    purple = "base0E",
    magenta = "base0E",
    white = "base05",
    bg_alt = "base01",
    bg_cur = "base01",
}

local M = {}
--- get a material color
---@param name string a color scheme's name
---@return table
M.get = function(name)
    if name == nil then
        local b, p = vim.g.colors_name:find("base16")
        -- if a base16 theme used
        if b then
            name = vim.g.colors_name:sub(p + 2)
        end
    end

    local mcolor = colors[name]
    if colors == nil then
        -- use a default base16 color
        mcolor = colors["material-darker"]
    end

    local color = {}
    for key, value in pairs(name_scheme) do
        color[key] = mcolor[value]
    end

    -- make accent as blue
    color.accent = color.blue
    return color
end
return M
