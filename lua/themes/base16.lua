local darken = require("themes.utils").darken
local lighten = require("themes.utils").lighten
local highlight = require("themes.utils").highlight

local function get_base16_colors(scheme)
    local style = scheme and scheme or require("settings").theme.base16_style
    local colors = require("base16-colorscheme").colorschemes[style]
    return colors
end

local function customize(scheme)
    local colors = get_base16_colors(scheme)
    local dbg010 = darken(colors.base00, 0.10)
    local dbg015 = darken(colors.base00, 0.15)
    local dbg020 = darken(colors.base00, 0.20)

    -- stylua: ignore
    highlight({
        -- vim commmon
        EndOfBuffer             = { fg = colors.base00, bg = colors.base00 },
        VertSplit               = { fg = dbg020 },
        CursorLineNr            = { fg = darken(colors.base0D, 0.1) },
        -- StatusLine              = { bg = colors.base00, fg = colors.base00 },
        -- StatusLineNC            = { bg = colors.base00, fg = colors.base00 },
        LineNr                  = { fg = colors.base03 },

        -- bufferline
        BufferLineIndicatorSelected = { fg = colors.base0D, bg = colors.base00 },
        BufferLineFill              = { fg = dbg010, bg = dbg010 },
        BufferLineTabClose          = { bg = dbg010 },

        -- wichkey
        WhichKeyFloat           = { bg = dbg010 },

        -- git
        gitblame                = { bg = colors.base01, fg = colors.base03 },

        -- nvimtree
        -- NvimTreeNormal          = { bg = dbg015 },
        SidebarTitle            = { bg = dbg010 },
        NvimTreeFolderIcon      = { fg = colors.base0D },
        NvimTreeIndentrker      = { fg = colors.base01 },
        -- NvimTreeEndOfBuffer     = { bg = dbg015, fg = dbg015 },
        -- NvimTreeVertSplit       = { bg = colors.base00, fg = colors.base00 },
        -- NvimTreeWinSeparator    = { bg = colors.base00, fg = colors.base00 },

        -- NormalFloat
        NormalFloat             = { bg = dbg010 },
        FloatBorder             = { bg = dbg010, fg = dbg010 },

        -- Packer
        PackerFloatNormal       = { bg = dbg010 },
        PackerFloatBorder       = { bg = dbg010, fg = dbg010 },

        -- Telescope
        TelescopePreviewNormal  = { bg = dbg020 },
        TelescopePreviewBorder  = { bg = dbg020, fg = dbg020 },
        TelescopePreviewTitle   = { bg = colors.base0B },

        -- cmp
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

        -- LSP
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

        -- Notify
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

        -- Outline
        OutlineNormal       = "NvimTreeNormal",
        OutlineEndOfBuffer  = "NvimTreeEndOfBuffer",
        OutlineSignColumn   = "OutlineNormal",
        OutlineLineNr       = "OutlineNormal",
        OutlineWinSeparator = "NvimTreeWinSeparator",
    })
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
        vim.wo.fillchars = "vert: "
        vim.cmd("setlocal winhighlight=" .. opts)
    end,
})
