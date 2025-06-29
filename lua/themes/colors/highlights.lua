local darken = require("themes.colors.manager").darken
local get_colors = require("themes.colors.manager").colors

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
function M.define()
    local colors = get_colors()
    -- print(vim.json.encode(colors))
    local dbg010 = darken(colors.base00, 0.10)
    local dbg015 = darken(colors.base00, 0.15)
    local dbg020 = darken(colors.base00, 0.20)
    local dbg030 = darken(colors.base00, 0.30)

    --stylua: ignore
    return {

        ----------------------------------------------------------------------
        --                           Vim Commons                            --
        ----------------------------------------------------------------------
        -- EndOfBuffer = { fg = colors.base00, bg              = colors.base00 },
        VertSplit                   = { fg = dbg020 },
        WinSeparator                = "VertSplit",
        CursorLineNr                = { fg = darken(colors.base0D, 0.1), bg = "None" },
        LineNr                      = { fg = colors.base03, bg = "None" },
        SignColumn                  = { bg = "None" },
        ColorColumn                 = { bg = "None" },
        CursorColumn                = { bg = "None" },
        -- Folded      = { fg = darken(colors.base0A, 0.20) },
        FoldColumn                  = { fg = colors.base03, bg = "None" },
        TabLineSel                  = { bg = colors.base0D },

        ----------------------------------------------------------------------
        --                           NormalFloat                            --
        ----------------------------------------------------------------------
        NormalFloat                 = { bg = dbg015 },
        FloatBorder                 = { bg = dbg015, fg = dbg015 },
        FloatTitle                  = { bg = colors.base00, fg = colors.base05 },

        ----------------------------------------------------------------------
        --                        indent blank line                         --
        ----------------------------------------------------------------------
        NonText                     = "IndentBlanklineChar",
        IndentLine                  = { fg = colors.base03 },
        IndentLineCurrent           = { fg = darken(colors.base04, .35) },

        ----------------------------------------------------------------------
        --                             Whichkey                             --
        ----------------------------------------------------------------------
        WhichKeyFloat               = { bg = dbg015 },

        ----------------------------------------------------------------------
        --                               git                                --
        ----------------------------------------------------------------------
        GitSignsCurrentLineBlame    = { fg = colors.base03, bg = dbg010 },
        GitSignHunkPreviewNormal    = "Normal",
        GitSignHunkPreviewBorder    = { fg = colors.base02 },
        GitSignsChange              = { fg = colors.base0C },
        GitSignsUntracked           = { fg = colors.base0A },
        GitSignsUntrackedLn         = "GitSignsUntracked",
        GitSignsUntrackedNr         = "GitSignsUntracked",

        ----------------------------------------------------------------------
        --                          NvimTreeNormal                          --
        ----------------------------------------------------------------------
        -- NvimTreeNormal       = { bg = dbg015 },
        -- NvimTreeSidebarTitle            = { bg = dbg015, fg = colors.base03 },
        -- NvimTreeFolderIcon              = { fg = colors.base0D },
        -- NvimTreeIndentrker              = { fg = colors.base01 },
        -- NvimTreeEndOfBuffer  = { bg = dbg015, fg        = dbg015 },
        -- NvimTreeVertSplit    = { bg = colors.base00, fg = colors.base00 },
        -- NvimTreeWinSeparator = { bg = colors.base00, fg = colors.base00 },

        ----------------------------------------------------------------------
        --                             NeoTree                              --
        ----------------------------------------------------------------------
        NeoTreeModified             = { fg = colors.base09 },

        -- NeoTree git signs
        NeoTreeGitAdded             = "GitSignsAdd",
        NeoTreeGitConflict          = { fg = colors.base0E },
        NeoTreeGitDeleted           = "GitSignsDelete",
        NeoTreeGitIgnored           = { fg = colors.base04 },
        NeoTreeGitModified          = "GitSignsChange",
        NeoTreeGitUnstaged          = { fg = colors.base09 },
        NeoTreeGitUntracked         = "GitSignsUntracked",
        NeoTreeGitStaged            = { fg = colors.base0B },

        -- inactive buffer
        NeoTreeTabInactive          = { fg = colors.base03, bg = dbg015 },
        NeoTreeTabSeparatorInactive = { fg = dbg015, bg = dbg015 },
        NeoTreeTabSeparatorActive   = { bg = colors.base00, fg = colors.base00 },

        ----------------------------------------------------------------------
        --                            for vim.ui                            --
        ----------------------------------------------------------------------
        InputUIFloatWinNormal       = { bg = colors.base00 },
        InputUIFloatBorder          = { fg = colors.base0D, bg = colors.base00 },
        InputUIFloatTitle           = { fg = colors.base0D, bg = colors.base00 },

        SelectUIFloatWinNormal      = { bg = colors.base00 },
        SelectUIFloatBorder         = { fg = colors.base0D, bg = colors.base00 },
        SelectUIFloatTitle          = { fg = colors.base0D, bg = colors.base00 },

        ----------------------------------------------------------------------
        --                              Packer                               --
        ----------------------------------------------------------------------
        PackerFloatNormal           = { bg = dbg015 },
        PackerFloatBorder           = { bg = dbg015, fg = dbg015 },

        ----------------------------------------------------------------------
        --                            Telescope                             --
        ----------------------------------------------------------------------
        TelescopePreviewNormal      = { bg = dbg020 },
        TelescopePreviewBorder      = { bg = dbg020, fg = dbg020 },
        TelescopePreviewTitle       = { bg = colors.base0B },
        TelescopeResultsLineNr      = { bg = "None" },
        TelescopePromptCounter      = { fg = darken(colors.base05, .60) },

        ----------------------------------------------------------------------
        --                          Snacks.picker                           --
        ----------------------------------------------------------------------
        SnacksPickerTitle           = { bg = colors.base08, fg = colors.base00 },
        SnacksPickerPreviewTitle    = { bg = colors.base0B, fg = colors.base00 },
        SnacksPickerPreview         = { bg = dbg030 },
        SnacksPickerPreviewBorder   = { bg = dbg030, fg = dbg030 },
        SnacksPickerInput           = { bg = darken(colors.base02, 0.1) },
        SnacksPickerInputBorder     = { bg = darken(colors.base02, 0.1), fg = darken(colors.base02, 0.1) },
        -- SnacksPickerBorder              = { bg = dbg030, fg = dbg030 },
        SnacksPickerList            = { bg = dbg010 },
        SnacksPickerListBorder      = { bg = dbg010, fg = dbg010 },
        -- SnacksPickerListCursorLine      = { bg = colors.base01, fg = colors.base06 },
        SnacksPickerDir             = { fg = darken(colors.base04, 0.1) },
        SnacksPickerTotals          = { fg = darken(colors.base05, 0.6) },
        SnacksPickerPrompt          = { fg = colors.base08 },

        SnacksDashBoardDesc         = { fg = darken(colors.base04, 0.3) },
        SnacksDashBoardIcon         = { fg = colors.base0D },
        SnacksDashBoardDir          = "SnacksDashBoardDesc",


        ----------------------------------------------------------------------
        --                               CMP                                --
        ----------------------------------------------------------------------
        PmenuSel                 = { bg = colors.base02, fg = nil },
        Pmenu                    = { bg = dbg015 },
        PmenuSbar                = { bg = darken(colors.base03, .60) },
        PmenuThumb               = { bg = darken(colors.base03, .30) },
        CmpItemAbbr              = { bg = nil },
        CmpItemAbbrMatch         = { fg = colors.base0D },
        CmpItemAbbrtMatchFuzzy   = { fg = colors.base0D },
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
        CmpItemKindCodeium       = { fg = colors.base0C },

        ----------------------------------------------------------------------
        --                            LSP COnfig                            --
        ----------------------------------------------------------------------
        LspFloatWinNormal        = { bg = colors.base00 },
        LspFloatWinBorder        = { bg = colors.base00, fg = colors.base02 },

        LspWinHoverNormal        = { bg = colors.base00 },
        LspWinHoverBorder        = { fg = darken(colors.base0C, .3), bg = colors.base00 },
        LspWinHoverTitle         = { fg = darken(colors.base0C, .3) },

        LspWinDiagnosticsNormal  = { bg = colors.base00 },
        LspWinDiagnosticsBorder  = { fg = darken(colors.base0C, 0.3), bg = colors.base00 },
        LspWinDiagnosticsTitle   = { fg = darken(colors.base0C, 0.3) },

        LspWinRenameTitle        = { bg = colors.base00, fg = colors.base0D },
        LspWinRenameBorder       = { bg = colors.base00, fg = colors.base0D },
        LspWinRenamePrompt       = { bg = colors.base00, fg = colors.base0D },

        LspWinCodeActionTitle    = { bg = colors.base00, fg = colors.base0D },
        LspWinCodeActionBorder   = { bg = colors.base00, fg = colors.base0D },

        LspInlayHint             = { fg = darken(colors.base04, .3), blend = 50 },

        ----------------------------------------------------------------------
        --                              Notify                              --
        ----------------------------------------------------------------------
        NotifyBackground         = { bg = colors.base00 },
        NotifyERROR              = { fg = colors.base08, bg = colors.base00 },
        NotifyWARN               = { fg = colors.base0E, bg = colors.base00 },
        NotifyINFO               = { fg = colors.base0B, bg = colors.base00 },
        NotifyDEBUG              = { fg = colors.base0C, bg = colors.base00 },
        NotifyTRACE              = { fg = colors.base0C, bg = colors.base00 },
        NotifyERRORBorder        = { fg = colors.base08, bg = colors.base00 },
        NotifyWARNBorder         = { fg = colors.base0E, bg = colors.base00 },
        NotifyINFOBorder         = { fg = colors.base0B, bg = colors.base00 },
        NotifyDEBUGBorder        = { fg = colors.base0C, bg = colors.base00 },
        NotifyTRACEBorder        = { fg = colors.base0C, bg = colors.base00 },
        NotifyERRORIcon          = { fg = colors.base08, bg = colors.base00 },
        NotifyWARNIcon           = { fg = colors.base0E, bg = colors.base00 },
        NotifyINFOIcon           = { fg = colors.base0B, bg = colors.base00 },
        NotifyDEBUGIcon          = { fg = colors.base0C, bg = colors.base00 },
        NotifyTRACEIcon          = { fg = colors.base0C, bg = colors.base00 },
        NotifyERRORTitle         = { fg = colors.base08, bg = colors.base00 },
        NotifyWARNTitle          = { fg = colors.base0E, bg = colors.base00 },
        NotifyINFOTitle          = { fg = colors.base0B, bg = colors.base00 },
        NotifyDEBUGTitle         = { fg = colors.base0C, bg = colors.base00 },
        NotifyTRACETitle         = { fg = colors.base0C, bg = colors.base00 },
        NotifyERRORBody          = 'Normal',
        NotifyWARNBody           = 'Normal',
        NotifyINFOBody           = 'Normal',
        NotifyDEBUGBody          = 'Normal',
        NotifyTRACEBody          = 'Normal',

        ----------------------------------------------------------------------
        --                             Outline                              --
        ----------------------------------------------------------------------
        -- OutlineSidebarTitle = { bg = dbg015, fg = colors.base03 },
        -- OutlineNormal       = "Normal",
        -- OutlineEndOfBuffer  = "NvimTreeEndOfBuffer",
        -- OutlineSignColumn   = "OutlineNormal",
        -- OutlineLineNr       = "OutlineNormal",
        -- OutlineWinSeparator = "WinSeparator",
        OutlinePreviewNormal     = { bg = dbg015, },
        FocusedSymbol            = { bg = colors.base01, fg = "None" }, -- gui = "None" },


        ----------------------------------------------------------------------
        --                            Dashboard                             --
        ----------------------------------------------------------------------
        DashboardHeader                   = { fg = colors.base0D },
        DashboardShortCut                 = { fg = colors.base0E },
        DashboardFooter                   = { fg = colors.base02 },
        DashboardKey                      = { fg = colors.base0E },

        DashboardProjectTitle             = { fg = colors.base0D },
        DashboardProjectTitleIcon         = "DashboardProjectTitle",
        DashboardProjectIcon              = { fg = colors.base0A },
        DashboardMruTitle                 = { fg = colors.base0D },
        DashboardMruIcon                  = "DashboardMruTitle",
        DashboardFiles                    = { fg = colors.base03 },

        DashboardActionFiles              = { fg = colors.base0A },
        DashboardActionNew                = { fg = colors.base0B },
        DashboardActionColors             = { fg = colors.base0E },
        DashboardActionUpdate             = { fg = colors.base0C },
        DashboardActionSettings           = { fg = colors.base08 },

        ----------------------------------------------------------------------
        --                             Trouble                              --
        ----------------------------------------------------------------------
        TroubleCount                      = { bg = "None", fg = colors.base0B },
        TroubleFoldIcon                   = "None",
        TroubleIndent                     = "None",
        TroubleLocation                   = { bg = "None", fg = colors.base03 },
        TroubleText                       = "None",

        ----------------------------------------------------------------------
        --                              Noice                               --
        ----------------------------------------------------------------------
        -- NoiceCmdlinePopup  = "TelescopePromptNormal",
        NoiceCmdlinePopup                 = { bg = darken(colors.base02, .1) },
        NoiceCmdlinePopupBorder           = { bg = darken(colors.base02, .1), fg = darken(colors.base02, .1) },
        NoiceCmdlinePopupTitle            = { bg = colors.base0D, fg = colors.base00 },
        NoiceCmdlineIcon                  = { fg = colors.base0D, bg = darken(colors.base02, 0.1) },
        NoiceConfirmBorder                = { fg = colors.base0B },
        NoiceConfirmTitle                 = { fg = colors.base0B },
        NoiceSplit                        = "Normal",
        NoiceVirtualText                  = { fg = darken(colors.base09, .25) },

        ----------------------------------------------------------------------
        --                         Rainbow delemers                         --
        ----------------------------------------------------------------------
        RainbowDelimiterRed               = { fg = colors.base08 },
        RainbowDelimiterYellow            = { fg = colors.base0A },
        RainbowDelimiterBlue              = { fg = colors.base0D },
        RainbowDelimiterOrange            = { fg = colors.base09 },
        RainbowDelimiterGreen             = { fg = colors.base0B },
        RainbowDelimiterViolet            = { fg = colors.base0E },
        RainbowDelimiterCyan              = { fg = colors.base0C },

        ----------------------------------------------------------------------
        --                        winbar and dropbar                        --
        ----------------------------------------------------------------------
        WinBar                            = { fg = darken(colors.base05, 0.25) },
        DropBarIconUISeparator            = "WinBar",
        DropBarIconUIIndicator            = "DropBarIconUISeparator",
        DropBarMenuHoverIcon              = "WinBar",

        ----------------------------------------------------------------------
        --                          LightBulbSign                           --
        ----------------------------------------------------------------------
        LightBulbSign                     = { fg = colors.base0A },

        ----------------------------------------------------------------------
        --                            ToggleTerm                            --
        ----------------------------------------------------------------------
        ToggleTermTitle                   = { fg = colors.base04 },

        ----------------------------------------------------------------------
        --                              glance                              --
        ----------------------------------------------------------------------
        GlancePreviewNormal               = { bg = dbg010 },
        GlancePreviewMatch                = "CursorLine",
        -- GlancePreviewCursorLine  = "GlancePreviewNormal",
        -- GlancePreviewSignColumn  = "GlancePreviewNormal",
        -- GlancePreviewFoldColumn  = { bg = dbg020 },
        -- GlancePreviewEndOfBuffer = "GlancePreviewNormal",
        -- GlancePreviewLineNr      = "GlancePreviewNormal",
        GlancePreviewBorderBottom         = { bg = colors.base00, fg = darken(colors.base0D, .20) },
        GlanceWinBarFilename              = { bg = colors.base00 },
        GlanceWinBarFilepath              = "GlanceWinBarFilename",
        GlanceWinBarTitle                 = "GlanceWinBarFilename",
        -- GlanceListNormal
        -- GlanceListFilename
        -- GlanceListFilepath
        -- GlanceListCount
        GlanceListMatch                   = { bg = darken(colors.base0D, .20), fg = colors.base00 },
        -- GlanceListCursorLine        = { bg = darken(colors.base0D, .40), fg = colors.base00 },
        -- GlanceListEndOfBuffer
        GlanceListBorderBottom            = "GlancePreviewBorderBottom",
        -- GlanceFoldIcon
        -- GlanceIndent
        GlanceBorderTop                   = "GlancePreviewBorderBottom",

        ----------------------------------------------------------------------
        --                             Lazygit                              --
        ----------------------------------------------------------------------
        LazygitActiveBorderColor          = { fg = colors.base0B },
        lazygitCherryPickedCommitBgColor  = { fg = colors.base00 },
        LazygitCherryPickedCommitFgColor  = { fg = colors.base0B },
        LazygitDefaultFgColor             = { fg = colors.base06 },
        LazygitInactiveBorderColor        = { fg = colors.base04 },
        LazygitOptionsTextColor           = { fg = colors.base0D },
        LazygitSearchingActiveBorderColor = { fg = colors.base0D },
        LazygitSelectedLineBgColor        = { bg = colors.base0D }, -- set to `default` to have no background colour
        LazygitUnstagedChangesColor       = { fg = colors.base08 },
    }
end

function M.set()
    require("themes.colors.manager").set_hl(M.define())
end

return M
