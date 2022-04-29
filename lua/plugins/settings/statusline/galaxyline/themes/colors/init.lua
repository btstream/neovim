local buffer = require("galaxyline.providers.buffer")
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

local filetype_colors = {
    DAPUI_WATCHES = "magenta",
    DAPUI_CONFIG = "magenta",
    DAPUI_SCOPES = "magenta",
    DAPUI_BREAKPOINTS = "magenta",
    ["DAP-REPL"] = "magenta",
    DAPUI_STACKS = "magenta",
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
            colors = require("plugins.settings.statusline.galaxyline.themes.colors.base16").get(
                "material" .. "-" .. vim.g.material_style
            )
            local mcolors = require("material.colors")
            colors = vim.tbl_extend("force", colors, mcolors)
            -- set background to a lighter colors for material themes
            colors.bg = colors.bg_cur
        elseif vim.g.colors_name:find("base16") then -- if base16 colors
            colors = require("plugins.settings.statusline.galaxyline.themes.colors.base16").get(nil)
        end
    end
    -- set a global color scheme
    vim.g.statusline_colors = colors
end

--- functions to get mode color
M.get_mode_color = function()
    local s = vim.g.statusline_colors[mode_color[vim.fn.mode()]]
    if vim.g.dap_loaded then
        s = vim.g.statusline_("magenta")
    end
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

M.set_filetype_color = function(group, fg)
    local x = "guibg"
    local g = "Galaxy" .. group
    if fg then
        x = "guifg"
    end

    local buftype = buffer.get_buffer_filetype()
    local color = vim.g.statusline_colors[filetype_colors[buftype]]
    if color then
        if type(color) == "function" then
            color = color()
        end
    else
        color = M.get_mode_color()
    end

    vim.cmd("hi! " .. g .. " " .. x .. "=" .. color)
end

setmetatable(M, {
    __index = function(self, key)
        if vim.g.statusline_colors[key] ~= nil then
            return vim.g.statusline_colors[key]
        else
            return self[key]
        end
    end,
})
return M
