local style = require("settings").theme.base16_style
local colors = require("base16-colorscheme").colorschemes[style]
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

-- local colors = {
--     base00 = "#282c34",
--     base0F = "#be5046",
--     base0E = "#c678dd",
--     base02 = "#3e4451",
--     base08 = "#e06c75",
--     base0B = "#98c379",
--     base0D = "#61afef",
--     base06 = "#b6bdca",
--     base09 = "#d19a66",
--     base0A = "#e5c07b",
--     base0C = "#56b6c2",
--     base07 = "#c8ccd4",
--     base03 = "#545862",
--     base01 = "#353b45",
--     base04 = "#565c64",
--     base05 = "#abb2bf",
-- }

local dbg010 = darken(colors.base00, 0.10)
local dbg015 = darken(colors.base00, 0.15)
local dbg020 = darken(colors.base00, 0.20)

local function highlight(opt)
    for key, value in pairs(opt) do
        if not (value.fg == nil and value.bg == nil and value.gui == nil) then
            local fg = value.fg and "guifg=" .. value.fg or "guifg=NONE"
            local bg = value.bg and "guibg=" .. value.bg or "guibg=NONE"
            local gui = value.gui and "gui=" .. value.gui or "gui=NONE"
            vim.cmd(string.format("hi! %s %s", key, bg .. " " .. fg .. " " .. gui))
        end
    end
end

require("base16-colorscheme").setup(colors)
highlight({
    -- common for nvim
    EndOfBuffer = { fg = colors.base00, bg = colors.base00 },
    VertSplit = { fg = dbg010 },
    -- LineNr = { fg = darken(colors.base03, 0.3) },
    CursorLineNr = { fg = darken(colors.base0D, 0.3) },
    StatusLine = { bg = colors.base00, fg = colors.base00 },
    StatusLineNC = { bg = colors.base00, fg = colors.base00 },

    -- bufferline
    BufferLineIndicatorSelected = { fg = colors.base0D, bg = colors.base00 },
    BufferLineFill = { fg = colors.base01, bg = colors.base01 },

    -- dashboard
    -- DashboardHeader = { fg = colors.base0B },

    -- wichkey
    WhichKeyFloat = { bg = colors.base02 },

    -- git
    gitblame = { bg = colors.base01, fg = colors.base04 },

    -- nvimtree
    NvimTreeNormal = { bg = dbg015 },
    NvimTreeFolderIcon = { fg = colors.base0D },
    NvimTreeIndentMarker = { fg = colors.base01 },
    NvimTreeEndOfBuffer = { bg = dbg015, fg = dbg015 },
    NvimTreeVertSplit = { bg = colors.base00, fg = colors.base00 },

    -- NormalFloat
    NormalFloat = { bg = colors.base02 },
    FloatBorder = { bg = colors.base02, fg = colors.base02 },

    -- Packer
    PackerFloatNormal = { bg = dbg010 },
    PackerFloatBorder = { bg = dbg010, fg = dbg010 },

    -- Telescope
    TelescopePreviewNormal = { bg = dbg020 },
    TelescopePreviewBorder = { bg = dbg020, fg = dbg020 },
    TelescopePreviewTitle = { bg = colors.base0B },

    -- cmp
    PmenuSel = { bg = dbg015 },
    Pmenu = { bg = dbg015 },

    -- CmpItemAbbr = { fg = colors.fg },
    -- CmpItemAbbrDeprecated = { fg = colors.fg },
    CmpItemAbbrMatch = { fg = colors.base0D, gui = "bold" },
    CmpItemAbbrMatchFuzzy = { fg = colors.base0D, gui = "underline" },
    CmpItemMenu = { fg = colors.base03 },

    CmpItemKindText = { fg = colors.base09 },
    CmpItemKindMethod = { fg = colors.base0D },
    CmpItemKindFunction = { fg = colors.base0D },
    CmpItemKindConstructor = { fg = colors.base0A },
    CmpItemKindField = { fg = colors.base0D },
    CmpItemKindClass = { fg = colors.base0A },
    CmpItemKindInterface = { fg = colors.base0A },
    CmpItemKindModule = { fg = colors.base0D },
    CmpItemKindProperty = { fg = colors.base0D },
    CmpItemKindValue = { fg = colors.base09 },
    CmpItemKindEnum = { fg = colors.base0A },
    CmpItemKindKeyword = { fg = colors.base0E },
    CmpItemKindSnippet = { fg = colors.base0B },
    CmpItemKindFile = { fg = colors.base0D },
    CmpItemKindEnumMember = { fg = colors.base0C },
    CmpItemKindConstant = { fg = colors.base09 },
    CmpItemKindStruct = { fg = colors.base0A },
    CmpItemKindTypeParameter = { fg = colors.base0A },

    CmpDocumentation = { bg = dbg015 },
    CmpDocumentationBorder = { fg = dbg015, bg = dbg015 },

    -- LSP
    LspFloatWinNormal = { bg = colors.base00 },
    LspFloatWinBorder = { bg = colors.base00, fg = colors.base02 },

    LspWinHoverNormal = { bg = dbg015 },
    LspWinHoverBorder = { fg = dbg015, bg = dbg015 },

    LspWinDiagnosticsNormal = { bg = colors.base00 },
    LspWinDiagnosticsBorder = { fg = darken(colors.base0C, 0.4), bg = colors.base00 },
    LspWinDiagnosticsTitle = { fg = darken(colors.base0C, 0.4) },

    LspWinRenameTitle = { bg = colors.base00, fg = colors.base0D },
    LspWinRenameBorder = { bg = colors.base00, fg = colors.base0D },
    LspWinRenamePrompt = { bg = colors.base00, fg = colors.base0D },

    LspWinCodeActionTitle = { bg = colors.base00, fg = colors.base0D },
    LspWinCodeActionBorder = { bg = colors.base00, fg = colors.base0D },
})
