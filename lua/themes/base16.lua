local darken = require("themes.utils").darken
local highlight = require("themes.utils").highlight

local function get_base16_colors(scheme)
    local style = scheme and scheme or require("settings").theme.base16_style
    local colors = require("base16-colorscheme").colorschemes[style]
    return colors
end

local function customize(scheme)
    local colors = get_base16_colors(scheme)
    -- print(vim.json.encode(colors))
    -- local dbg010 = darken(colors.base00, 0.10)
    local dbg015 = darken(colors.base00, 0.15)
    local dbg020 = darken(colors.base00, 0.20)

    -- stylua: ignore
    local custom_colors = {

        ----------------------------------------------------------------------
        --                           Vim Commons                            --
        ----------------------------------------------------------------------
        -- EndOfBuffer             = { fg = colors.base00, bg = colors.base00 },
        VertSplit               = { fg = dbg020 },
        CursorLineNr            = { fg = darken(colors.base0D, 0.1) },
        LineNr                  = { fg = colors.base03 },
        SignColumn              = { bg = "None"},
        -- Folded                  = { fg = darken(colors.base0A, 0.20) },

        ----------------------------------------------------------------------
        --                             Whichkey                             --
        ----------------------------------------------------------------------
        WhichKeyFloat           = { bg = dbg015 },

        ----------------------------------------------------------------------
        --                               git                                --
        ----------------------------------------------------------------------
        gitblame                = { bg = colors.base01, fg = colors.base03 },

        ----------------------------------------------------------------------
        --                          NvimTreeNormal                          --
        ----------------------------------------------------------------------
        -- NvimTreeNormal          = { bg = dbg015 },
        SidebarTitle            = { bg = dbg015 },
        NvimTreeFolderIcon      = { fg = colors.base0D },
        NvimTreeIndentrker      = { fg = colors.base01 },
        -- NvimTreeEndOfBuffer     = { bg = dbg015, fg = dbg015 },
        -- NvimTreeVertSplit       = { bg = colors.base00, fg = colors.base00 },
        -- NvimTreeWinSeparator    = { bg = colors.base00, fg = colors.base00 },

        ----------------------------------------------------------------------
        --                           NormalFloat                            --
        ----------------------------------------------------------------------
        NormalFloat             = { bg = dbg015 },
        FloatBorder             = { bg = dbg015, fg = dbg015 },

        ----------------------------------------------------------------------
        --                              Pacer                               --
        ----------------------------------------------------------------------
        PackerFloatNormal       = { bg = dbg015 },
        PackerFloatBorder       = { bg = dbg015, fg = dbg015 },

        ----------------------------------------------------------------------
        --                            Telescope                             --
        ----------------------------------------------------------------------
        TelescopePreviewNormal  = { bg = dbg020 },
        TelescopePreviewBorder  = { bg = dbg020, fg = dbg020 },
        TelescopePreviewTitle   = { bg = colors.base0B },
        TelescopeResultsLineNr  = { bg = "None" },

        ----------------------------------------------------------------------
        --                               CMP                                --
        ----------------------------------------------------------------------
        PmenuSel                 = { bg = colors.base02, fg = 'None' },
        Pmenu                    = { bg = dbg015 },
        CmpItemAbbrMatch         = { fg = colors.base0D, gui = "bold" },
        CmpItemAbbrtMatchFuzzy   = { fg = colors.base0D, gui = "underline" },
        CmpItemnu                = { fg = colors.base03 },
        CmpItemKindText          = { fg = colors.base09 },
        CmpItemKindthod          = { fg = colors.base0D },
        CmpItemKindFunction      = { fg = colors.base0D },
        CmpItemKindConstructor   = { fg = colors.base0A },
        CmpItemKindField         = { fg = colors.base0D },
        CmpItemKindClass         = { fg = colors.base0A },
        CmpItemKindInterface     = { fg = colors.base0A },
        CmpItemKinddule          = { fg = colors.base0D },
        CmpItemKindProperty      = { fg = colors.base0D },
        CmpItemKindValue         = { fg = colors.base09 },
        CmpItemKindEnum          = { fg = colors.base0A },
        CmpItemKindKeyword       = { fg = colors.base0E },
        CmpItemKindSnippet       = { fg = colors.base0B },
        CmpItemKindFile          = { fg = colors.base0D },
        CmpItemKindEnummber      = { fg = colors.base0C },
        CmpItemKindConstant      = { fg = colors.base09 },
        CmpItemKindStruct        = { fg = colors.base0A },
        CmpItemKindTypeParameter = { fg = colors.base0A },
        CmpDocumentation         = { bg = dbg015 },
        CmpDocumentationBorder   = { fg = dbg015, bg = dbg015 },

        ----------------------------------------------------------------------
        --                            LSP COnfig                            --
        ----------------------------------------------------------------------
        LspFloatWinNormal       = { bg = colors.base00 },
        LspFloatWinBorder       = { bg = colors.base00, fg = colors.base02 },

        LspWinHoverNormal       = { bg = dbg015 },

        LspWinHoverBorder       = { fg = dbg015, bg = dbg015 },
        LspWinDiagnosticsNormal = { bg = colors.base00 },
        LspWinDiagnosticsBorder = { fg = darken(colors.base0C, 0.4), bg = colors.base00 },
        LspWinDiagnosticsTitle  = { fg = darken(colors.base0C, 0.4) },

        LspWinRenameTitle       = { bg = colors.base00, fg = colors.base0D },
        LspWinRenameBorder      = { bg = colors.base00, fg = colors.base0D },
        LspWinRenamePrompt      = { bg = colors.base00, fg = colors.base0D },

        LspWinCodeActionTitle   = { bg = colors.base00, fg = colors.base0D },
        LspWinCodeActionBorder  = { bg = colors.base00, fg = colors.base0D },

        ----------------------------------------------------------------------
        --                              Notify                              --
        ----------------------------------------------------------------------
        NotifyERRORBorder = { fg = colors.base08, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyWARNBorder  = { fg = colors.base0E, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyINFOBorder  = { fg = colors.base0B, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyDEBUGBorder = { fg = colors.base0C, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyTRACEBorder = { fg = colors.base0C, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyERRORIcon   = { fg = colors.base08, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyWARNIcon    = { fg = colors.base0E, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyINFOIcon    = { fg = colors.base0B, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyDEBUGIcon   = { fg = colors.base0C, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyTRACEIcon   = { fg = colors.base0C, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyERRORTitle  = { fg = colors.base08, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyWARNTitle   = { fg = colors.base0E, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyINFOTitle   = { fg = colors.base0B, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyDEBUGTitle  = { fg = colors.base0C, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyTRACETitle  = { fg = colors.base0C, guibg = colors.base00, gui = nil, guisp = nil },
        NotifyERRORBody   = 'Normal',
        NotifyWARNBody    = 'Normal',
        NotifyINFOBody    = 'Normal',
        NotifyDEBUGBody   = 'Normal',
        NotifyTRACEBody   = 'Normal',

        ----------------------------------------------------------------------
        --                             Outline                              --
        ----------------------------------------------------------------------
        OutlineNormal       = "NvimTreeNormal",
        OutlineEndOfBuffer  = "NvimTreeEndOfBuffer",
        OutlineSignColumn   = "OutlineNormal",
        OutlineLineNr       = "OutlineNormal",
        OutlineWinSeparator = "NvimTreeWinSeparator",
        FocusedSymbol       = { bg = colors.base01, fg = "None", gui = "None" },

        ----------------------------------------------------------------------
        --                             BuffLine                             --
        ----------------------------------------------------------------------
        -- normal tab
        BufferLineBackground        = { bg = dbg015 },
        BufferLineModified          = { bg = dbg015 },
        BufferLineDuplicate         = { bg = dbg015 },
        BufferLinePick              = { bg = dbg015 },
        BufferLineSeparator         = { bg = dbg015, fg = dbg015 },
        BufferLineBuffer            = { bg = dbg015 },
        BufferLineDiagnostic        = { bg = dbg015 },
        BufferLineError             = { bg = dbg015 },
        BufferLineErrorDiagnostic   = { bg = dbg015 },
        BufferLineWarning           = { bg = dbg015 },
        BufferLineWarningDiagnostic = { bg = dbg015 },
        BufferLineInfo              = { bg = dbg015 },
        BufferLineInfoDiagnostic    = { bg = dbg015 },
        BufferLineHint              = { bg = dbg015 },
        BufferLineHintDiagnostic    = { bg = dbg015 },
        BufferLineCloseButton       = { bg = dbg015 },
        BufferLineNumbers           = { bg = dbg015 },

        BufferLineBackgroundVisible        = { bg = dbg015 },
        BufferLineModifiedVisible          = { bg = dbg015 },
        BufferLineDuplicateVisible         = { bg = dbg015 },
        BufferLinePickVisible              = { bg = dbg015 },
        BufferLineSeparatorVisible         = { bg = dbg015, fg = dbg015 },
        BufferLineBufferVisible            = { bg = dbg015 },
        BufferLineDiagnosticVisible        = { bg = dbg015 },
        BufferLineErrorVisible             = { bg = dbg015 },
        BufferLineErrorDiagnosticVisible   = { bg = dbg015 },
        BufferLineWarningVisible           = { bg = dbg015 },
        BufferLineWarningDiagnosticVisible = { bg = dbg015 },
        BufferLineInfoVisible              = { bg = dbg015 },
        BufferLineInfoDiagnosticVisible    = { bg = dbg015 },
        BufferLineHintVisible              = { bg = dbg015 },
        BufferLineHintDiagnosticVisible    = { bg = dbg015 },
        BufferLineCloseButtonVisible       = { bg = dbg015 },
        BufferLineNumbersVisible           = { bg = dbg015 },

        -- selected
        BufferLineIndicatorSelected = { fg = colors.base0D, bg = colors.base00 },
        BufferLineSeparatorSelected = { bg = dbg015, fg = dbg015 },

        -- fill and close button
        BufferLineFill              = { bg = dbg015, fg = dbg015 },
        BufferLineTabClose          = { bg = dbg015 },
    }

    highlight(custom_colors)
end

-- load colors
require("base16-colorscheme").setup(get_base16_colors())

-- do customs
customize()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        local b, p = vim.g.colors_name:find("base16")
        if b then
            customize(vim.g.colors_name:sub(p + 2))
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "Outline",
    callback = function()
        local opts = "Normal:OutlineNormal,"
            .. "NormalNC:OutlineNormal,"
            .. "EndOfBuffer:OutlineEndOfBuffer,"
            .. "SignColumn:OutlineNormal,"
            .. "LineNr:OutlineLineNr,"
            .. "VertSplit:OutlineWinSeparator,"
            .. "WinSeparator:OutlineWinSeparator,"
        vim.wo.list = false
        vim.cmd("setlocal winhighlight=" .. opts)
    end,
})
