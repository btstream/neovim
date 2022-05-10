-------------------------------
--utils functions from base16
-------------------------------
local hex_re = vim.regex("#\\x\\x\\x\\x\\x\\x")

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

local function hex_to_rgb(hex)
    return HEX_DIGITS[string.sub(hex, 1, 1)] * 16 + HEX_DIGITS[string.sub(hex, 2, 2)],
        HEX_DIGITS[string.sub(hex, 3, 3)] * 16 + HEX_DIGITS[string.sub(hex, 4, 4)],
        HEX_DIGITS[string.sub(hex, 5, 5)] * 16 + HEX_DIGITS[string.sub(hex, 6, 6)]
end

local function rgb_to_hex(r, g, b)
    return bit.tohex(bit.bor(bit.lshift(r, 16), bit.lshift(g, 8), b), 6)
end

local function darken(hex, pct)
    pct = 1 - pct
    local r, g, b = hex_to_rgb(string.sub(hex, 2))
    r = math.floor(r * pct)
    g = math.floor(g * pct)
    b = math.floor(b * pct)
    return string.format("#%s", rgb_to_hex(r, g, b))
end

local function lighten(hex, pct)
    pct = 1 + pct
    local r, g, b = hex_to_rgb(string.sub(hex, 2))
    r = math.floor(r * pct)
    g = math.floor(g * pct)
    b = math.floor(b * pct)
    return string.format("#%s", rgb_to_hex(r, g, b))
end

--------------------------------
-- custom functions
--------------------------------
-- function to highligt groups
local function highlight(opts)
    vim.validate({
        opts = { opts, "t" },
    })
    for hl_group, scheme in pairs(opts) do
        if type(scheme) == "string" then
            vim.cmd(string.format("hi! link %s %s", hl_group, scheme))
        end

        if type(scheme) == "table" then
            local cmd = {}
            table.insert(cmd, "highlight! " .. hl_group)
            local has_style = false
            for key, color in pairs(scheme) do
                if color == nil then
                    goto continue
                end

                if key == "bg" then
                    table.insert(cmd, "guibg=" .. color)
                    has_style = true
                end

                if key == "fg" then
                    table.insert(cmd, "guifg=" .. color)
                    has_style = true
                end

                if key == "gui" then
                    table.insert(cmd, "gui=" .. color)
                    has_style = true
                end

                if key == "guisp" then
                    table.insert(cmd, "guisp=" .. color)
                    has_style = true
                end

                if key == "cterm" then
                    table.insert(cmd, "cterm=" .. color)
                    has_style = true
                end

                ::continue::
            end

            if has_style then
                vim.cmd(table.concat(cmd, " "))
            end
        end
    end
end

return {
    darken = darken,
    lighten = lighten,
    hilight = highlight,
}
