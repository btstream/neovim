local M = {}

local mode_color = { -- {{{2
    c = "magenta",
    ["!"] = "red",
    i = "green",
    ic = "yellow",
    ix = "yellow",
    n = "accent",
    no = "accent",
    nov = "accent",
    noV = "accent",
    r = "cyan",
    rm = "cyan",
    ["r?"] = "cyan",
    R = "purple",
    Rv = "purple",
    s = "orange",
    S = "orange",
    [""] = "orange",
    t = "cyan",
    v = "red",
    V = "red",
    -- [''] = colors.red
}

--- update color scheme. If no param is given, it will generate color automaytically
--- based on global color scheme. For now, base16 color scheme and material color
--- scheme is supported automaytically
---@param colors table
M.init_or_update = function(colors)
    -- generate colors from global colorscheme
    if colors == nil then
        -- generate colors for material colors
        if vim.g.colors_name == "material" then
            colors = require("plugins.settings.statusline.themes.colors.base16").get(
                "material" .. "-" .. vim.g.material_style
            )
            local mcolors = require("material.colors")
            colors = vim.tbl_extend("force", colors, mcolors)
        elseif vim.g.colors_name:find("base16") then -- if base16 colors
            colors = require("plugins.settings.statusline.themes.colors.base16").get(nil)
        end
    end
    print(vim.json.encode(colors))
    -- set a global color scheme
    vim.g.statusline_colors = colors
end

--- functions to get mode color
M.get_mode_color = function()
    local s = vim.g.statusline_colors[mode_color[vim.fn.mode()]]
    if vim.g.dap_loaded then
        s = vim.g.statusline_colors.magenta
    end
    print(s)
    if type(s) == "function" then
        return s()
    else
        return s
    end
end

--- set set_indicator_color with mode
---@param group string highlight group
---@param fg boolean set true to set foreground
M.set_indicator_color = function(group, fg)
    local x = "guibg"
    local g = "Galaxy" .. group
    if fg then
        x = "guifg"
    end
    vim.cmd("hi! " .. g .. " " .. x .. "=" .. M.get_mode_color())
end
return M
