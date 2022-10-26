local darken = require("themes.utils").darken
local get_base16_colors = require("themes.base16.colors").colors

local M = {}

-- color reference
-- {
--   "base0F": "#be5046",
--   "base0D": "#61afef",
--   "base07": "#c8ccd4",
--   "base05": "#abb2bf",
--   "base0E": "#c678dd",
--   "base02": "#3e4451",
--   "base0C": "#56b6c2",
--   "base01": "#353b45",
--   "base0B": "#98c379",
--   "base0A": "#e5c07b",
--   "base09": "#d19a66",
--   "base00": "#282c34",
--   "base08": "#e06c75",
--   "base03": "#545862",
--   "base06": "#b6bdca",
--   "base04": "#565c64"
-- }
function M.hg()
    local colors = get_base16_colors()
    -- print(vim.json.encode(colors))
    -- local dbg010 = darken(colors.base00, 0.10)
    local dbg015 = darken(colors.base00, 0.15)
    local dbg020 = darken(colors.base00, 0.20)

    --stylua: ignore
    return {

        ----------------------------------------------------------------------
        --                           Vim Commons                            --
        ----------------------------------------------------------------------
        -- EndOfBuffer             = { fg = colors.base00, bg = colors.base00 },
        VertSplit               = { fg = dbg020 },
        CursorLineNr            = { fg = darken(colors.base0D, 0.1) },
        LineNr                  = { fg = colors.base03 },
        SignColumn              = { bg = "None"},
        -- Folded                  = { fg = darken(colors.base0A, 0.20) },
        TabLineSel              = { bg = colors.base0D },

        ----------------------------------------------------------------------
        --                             Whichkey                             --
        ----------------------------------------------------------------------
        WhichKeyFloat           = { bg = dbg015 },

        ----------------------------------------------------------------------
        --                               git                                --
        ----------------------------------------------------------------------
        GitSignsCurrentLineBlame  = { fg = colors.base03 },
        GitSignHunkPreviewNormal  = "Normal",
        GitSignHunkPreviewBorder  = { fg = colors.base02 },

        ----------------------------------------------------------------------
        --                          NvimTreeNormal                          --
        ----------------------------------------------------------------------
        -- NvimTreeNormal          = { bg = dbg015 },
        NvimTreeSidebarTitle    = { bg = dbg015, fg = colors.base03 },
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
        -- for dressing
        FloatTitle              = { bg = colors.base00, fg = colors.base05 },

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
        CmpItemAbbr              = { bg = dbg015 },
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
        --                           Winbar Navic                           --
        ----------------------------------------------------------------------
        NavicIconsString        = { fg = colors.base0B },
        NavicIconsMethod        = { fg = colors.base0D },
        NavicIconsFunction      = { fg = colors.base0D },
        NavicIconsConstructor   = { fg = colors.base0A },
        NavicIconsField         = { fg = colors.base0D },
        NavicIconsClass         = { fg = colors.base0A },
        NavicIconsInterface     = { fg = colors.base0A },
        NavicIconsModule        = { fg = colors.base0D },
        NavicIconsProperty      = { fg = colors.base0D },
        NavicIconsValue         = { fg = colors.base09 },
        NavicIconsEnum          = { fg = colors.base0A },
        NavicIconsKey           = { fg = colors.base0E },
        NavicIconsSnippet       = { fg = colors.base0B },
        NavicIconsFile          = { fg = colors.base0D },
        NavicIconsEnumMember    = { fg = colors.base0C },
        NavicIconsConstant      = { fg = colors.base09 },
        NavicIconsStruct        = { fg = colors.base0A },
        NavicIconsTypeParameter = { fg = colors.base0A },
        NavicIconsNamespace     = { fg = colors.base0B },
        NavicIconsPackage       = "NavicIconsModule",
        NavicIconsVariable      = { fg = colors.base0E },
        NavicIconsBoolean       = { fg = colors.base0D },
        NavicIconsArray         = "NavicIconsEnum",
        NavicIconsObject        = "NavicIconsArray",
        NavicIconsNull          = { fg = colors.base0E },
        NavicIconsEvent         = { fg = colors.base09 },

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
        OutlineSidebarTitle = { bg = dbg015, fg = colors.base03 },
        OutlineNormal       = "NvimTreeNormal",
        OutlineEndOfBuffer  = "NvimTreeEndOfBuffer",
        OutlineSignColumn   = "OutlineNormal",
        OutlineLineNr       = "OutlineNormal",
        OutlineWinSeparator = "NvimTreeWinSeparator",
        FocusedSymbol       = { bg = colors.base01, fg = "None", gui = "None" },

        ----------------------------------------------------------------------
        --                            Dashboard                             --
        ----------------------------------------------------------------------
        DashboardHeader             = { fg = colors.base0D },
        DashboardCenter             = { fg = colors.base09 },
        DashboardCenterIcon         = { fg = colors.base0B },
        DashboardShortCut           = { fg = colors.base0E },
        DashboardFooter             = { fg = colors.base04 },

        ----------------------------------------------------------------------
        --                             Trouble                              --
        ----------------------------------------------------------------------
        TroubleCount        = { bg = "None", fg = colors.base0B },
        TroubleFoldIcon     = "None",
        TroubleIndent       = "None",
        TroubleLocation     = { bg = "None", fg = colors.base03 },
        TroubleText         = "None",

        ----------------------------------------------------------------------
        --                          LightBulbSign                           --
        ----------------------------------------------------------------------
        LightBulbSign   = { fg = colors.base0A }
    }
end

return M
