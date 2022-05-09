local colors = vim.tbl_extend("keep", {
    bg = "#2e3440",
    fg = "#ECEFF4",
    red = "#bf616a",
    orange = "#d08770",
    yellow = "#ebcb8b",
    blue = "#5e81ac",
    green = "#a3be8c",
    cyan = "#88c0d0",
    magenta = "#b48ead",
    pink = "#FFA19F",
    grey1 = "#f8fafc",
    grey2 = "#f0f1f4",
    grey3 = "#eaecf0",
    grey4 = "#d9dce3",
    grey5 = "#c4c9d4",
    grey6 = "#b5bcc9",
    grey7 = "#929cb0",
    grey8 = "#8e99ae",
    grey9 = "#74819a",
    grey10 = "#616d85",
    grey11 = "#464f62",
    grey12 = "#3a4150",
    grey13 = "#333a47",
    grey14 = "#242932",
    grey15 = "#1e222a",
    grey16 = "#1c1f26",
    grey17 = "#0f1115",
    grey18 = "#0d0e11",
    grey19 = "#020203",
}, require("onenord.colors.onenord"))

require("onenord").setup({
    borders = false,
    fade_nc = false,
    styles = {
        strings = "NONE",
        keywords = "NONE",
        -- diagnostics = "underline",
    },
    disable = {
        background = false,
        cursorline = false,
        eob_lines = true,
    },
    custom_highlights = {
        VertSplit = { fg = colors.grey14 },
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
        NormalFloat = { bg = colors.bg },
        FloatBorder = { bg = colors.grey14, fg = colors.grey14 },

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
    },
})
