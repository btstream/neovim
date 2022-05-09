local style = require("settings").theme.base16_style
local colors = require("base16-colorscheme").colorschemes[style]
local hi = require("base16-colorscheme").highlight
local function highlight(opt)
    for key, value in pairs(opt) do
        local fg = value.fg and "guifg=" .. value.fg or ""
        local bg = value.bg and "guibg=" .. value.bg or ""
        if not (fg == "" and bg == "") then
            vim.cmd("hi! %s %s", key, bg .. " " .. fg)
        end
    end
end

require("base16-colorscheme").setup(colors)
highlight({
    VertSplit = { fg = colors.bg },
    BufferLineIndicatorSelected = { fg = colors.cyan, bg = colors.bg },
    BufferLineFill = { fg = colors.fg, bg = colors.grey14 },

    -- dashboard
    DashboardHeader = { fg = colors.green },

    -- wichkey
    WhichKeyFloat = { bg = colors.grey14 },

    -- git
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.orange },
    GitSignsDelete = { fg = colors.red },
    gitblame = { bg = colors.active, fg = colors.light_gray },

    -- nvimtree
    NvimTreeNormal = { fg = colors.grey5, bg = colors.grey13 },
    NvimTreeFolderIcon = { fg = colors.grey9 },
    NvimTreeIndentMarker = { fg = colors.grey12 },

    -- NormalFloat
    NormalFloat = { bg = colors.grey14 },
    FloatBorder = { bg = colors.grey14, fg = colors.grey14 },

    -- Packer
    PackerFloatNormal = { bg = colors.grey14 },
    PackerFloatBorder = { bg = colors.grey14, fg = colors.grey14 },

    -- Telescope
    TelescopePromptPrefix = { bg = colors.grey14 },
    TelescopePromptNormal = { bg = colors.grey14 },
    TelescopeResultsNormal = { bg = colors.grey15 },
    TelescopePreviewNormal = { bg = colors.grey16 },

    TelescopePromptBorder = { bg = colors.grey14, fg = colors.grey14 },
    TelescopeResultsBorder = { bg = colors.grey15, fg = colors.grey15 },
    TelescopePreviewBorder = { bg = colors.grey16, fg = colors.grey16 },

    TelescopePromptTitle = { fg = colors.grey14 },
    TelescopeResultsTitle = { fg = colors.grey15 },
    TelescopePreviewTitle = { fg = colors.grey16 },

    -- cmp
    PmenuSel = { bg = colors.grey12 },
    Pmenu = { bg = colors.grey14 },
    CmpDocumentation = { bg = colors.grey14 },
    CmpDocumentationBorder = { fg = colors.grey14, bg = colors.grey14 },

    -- LSP
    LspFloatWinNormal = { bg = colors.bg, fg = colors.fg },
    LspFloatWinBorder = { bg = colors.bg, fg = colors.fg },

    LspWinHoverNormal = { bg = colors.bg },
    LspWinHoverBorder = { fg = colors.grey10, bg = colors.bg },

    LspWinDiagnosticsNormal = { bg = colors.bg },
    LspWinDiagnosticsBorder = { fg = colors.pink, bg = colors.bg },
    LspWinDiagnosticsTitle = { fg = colors.pink },

    LspWinRenameTitle = { bg = colors.bg, fg = colors.blue },
    LspWinRenameBorder = { bg = colors.bg, fg = colors.blue },
    LspWinRenamePrompt = { bg = colors.bg, fg = colors.blue },

    LspWinCodeActionTitle = { bg = colors.bg, fg = colors.blue },
    LspWinCodeActionBorder = { bg = colors.bg, fg = colors.blue },
})
