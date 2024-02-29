-------------------------------
--utils functions from base16
-------------------------------
-- local hex_re = vim.regex("#\\x\\x\\x\\x\\x\\x")
local HEX_DIGITS = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["a"] = 10,
    ["b"] = 11,
    ["c"] = 12,
    ["d"] = 13,
    ["e"] = 14,
    ["f"] = 15,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15,
}

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

local function hex_to_rgb(hex)
    return HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + HEX_DIGITS[string.sub(hex, 2, 2)],
        HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + HEX_DIGITS[string.sub(hex, 4, 4)],
        HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + HEX_DIGITS[string.sub(hex, 6, 6)]
end

local function rgb_to_hex(r, g, b)
    return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local color_scheme = nil
local function get_color_scheme(scheme)
    local style = scheme and scheme
    if scheme == nil then
        if vim.g.colors_name == nil then
            style = vim.tbl_get(require("settings"), "theme", "color_scheme")
        else
            local b, s = vim.g.colors_name:find("base16")
            if b then
                style = vim.g.colors_name:sub(s + 2)
            else
                style = vim.tbl_get(require("settings"), "theme", "color_scheme") --require("settings").theme.color_scheme
            end
        end
    end
    style = style and style:gsub("^(harmonic)-(.*)", "%116-%2") or "onedark"
    local ret = require("base16-colorscheme").colorschemes[style]
    return ret
end

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        color_scheme = get_color_scheme()
    end,
})

local M = {}

function M.darken(hex, pct)
    pct = 1 - pct
    local r, g, b = hex_to_rgb(string.sub(hex, 2))
    r = math.floor(r * pct)
    g = math.floor(g * pct)
    b = math.floor(b * pct)
    return string.format("#%s", rgb_to_hex(r, g, b))
end

function M.set_hl(opts)
    for hl_group, scheme in pairs(opts) do
        if type(scheme) == "string" then
            vim.api.nvim_set_hl(0, hl_group, { link = scheme })
        end

        if type(scheme) == "table" then
            vim.api.nvim_set_hl(0, hl_group, scheme)
        end
    end
end

function M.get_mode_color(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    local colors = require("themes.colors.manager").colors()
    local bg, fg = mode_colors_map[mode], "black"
    if colors then
        bg, fg = colors[comman_color_base16_map[bg]], colors[comman_color_base16_map[fg]]
    end
    return { bg = bg, fg = fg }
end

function M.get_named_color(name)
    local colors = M.colors()
    if comman_color_base16_map[name] then
        return colors[comman_color_base16_map[name]]
    end
    return name
end

function M.colors(scheme)
    if scheme ~= nil then
        return get_color_scheme(scheme)
    end

    if color_scheme == nil then
        color_scheme = get_color_scheme()
    end

    return color_scheme
end

return M
