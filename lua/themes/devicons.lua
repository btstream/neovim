-- nvim-web-devicons ships a fixed brand color for every filetype. Remap each
-- color to the closest color of the active base16 theme so file icons follow
-- the colorscheme, the same way bufferline highlights are derived from it.
local manager = require("themes.colors.manager")

local M = {}

-- Built-in colors saved before the first remap, so switching to another theme
-- still maps from the original colors instead of the already themed ones.
local originals = {}
-- One color map per theme, so switching back reuses the computed result.
local maps = {}

local function hex_to_rgb(hex)
    return tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
end

-- Weighted RGB distance: green dominates perceived brightness the most.
local function color_distance(r1, g1, b1, r2, g2, b2)
    local dr, dg, db = r1 - r2, g1 - g2, b1 - b2
    return 2 * dr * dr + 4 * dg * dg + 3 * db * db
end

local function theme_map(colors)
    -- Map onto the base16 accents plus the darker grays, so icons stay
    -- distinguishable without introducing colors the theme never uses.
    local pool = {
        colors.base08, colors.base09, colors.base0A, colors.base0B,
        colors.base0C, colors.base0D, colors.base0E, colors.base0F,
        colors.base03, colors.base04,
    }
    local parsed = {}
    for _, hex in ipairs(pool) do
        local r, g, b = hex_to_rgb(hex)
        parsed[#parsed + 1] = { r = r, g = g, b = b, hex = hex }
    end

    return function(hex)
        local r, g, b = hex_to_rgb(hex)
        local best, best_distance = pool[1], math.huge
        for _, entry in ipairs(parsed) do
            local distance = color_distance(r, g, b, entry.r, entry.g, entry.b)
            if distance < best_distance then
                best, best_distance = entry.hex, distance
            end
        end
        return best
    end
end

function M.apply()
    local devicons = require("nvim-web-devicons")
    -- setup() is one-shot: call it first so it registers the plugin's own
    -- ColorScheme handler, before other plugins can call it with options.
    devicons.setup()

    local scheme = vim.g.colors_name or "default"
    local map = maps[scheme]
    if not map then
        map = theme_map(manager.colors())
        maps[scheme] = map
    end

    -- Lookup tables share icon entries, so recolor each entry only once.
    local seen = {}
    local function recolor(entry)
        if type(entry) ~= "table" or seen[entry] or not entry.color then
            return
        end
        seen[entry] = true
        if originals[entry] == nil then
            originals[entry] = entry.color
        end
        entry.color = map(originals[entry])
    end

    for _, entry in pairs(devicons.get_icons()) do
        recolor(entry)
    end
    recolor(devicons.get_default_icon())

    -- setup() only defines highlights that do not exist yet, so force a
    -- refresh to make already loaded UIs pick up the remapped colors.
    devicons.set_up_highlights(true)
end

return M
