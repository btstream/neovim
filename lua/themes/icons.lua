local M = {}

-- stylua: ignore start
M.lsp_symbols     = {
    Text          = "",
    Method        = "",
    Function      = "",
    Constructor   = "",
    Field         = "",
    Variable      = "",
    Class         = "",
    Interface     = "",
    Module        = "",
    Property      = "",
    Unit          = "",
    Value         = "",
    Enum          = "",
    Keyword       = "",
    Snippet       = "",
    Color         = "",
    File          = "",
    Reference     = "",
    Folder        = "",
    EnumMember    = "",
    Constant      = "",
    Struct        = "פּ",
    Event         = "",
    Operator      = "",
    TypeParameter = "",
}

M.lsp_diagnostic_signs = {
    Error              = "",
    Warn               = "",
    Hint               = "",
    Info               = "",
}

M.mode_icons  = {
    ["n"]     = "",
    ["no"]    = "",
    ["nov"]   = "",
    ["noV"]   = "",
    ["no\22"] = "",
    ["niI"]   = "",
    ["niR"]   = "",
    ["niV"]   = "",
    ["nt"]    = "",
    ["v"]     = "ﱐ",
    ["vs"]    = "ﱐ",
    ["V"]     = "ﱐ",
    ["Vs"]    = "ﱐ",
    ["\22"]   = "ﱐ",
    ["\22s"]  = "ﱐ",
    ["s"]     = "",
    ["S"]     = "",
    ["\19"]   = "",
    ["i"]     = "",
    ["ic"]    = "",
    ["ix"]    = "",
    ["R"]     = "﯒",
    ["Rc"]    = "﯒",
    ["Rx"]    = "﯒",
    ["Rv"]    = "﯒",
    ["Rvc"]   = "﯒",
    ["Rvx"]   = "﯒",
    ["c"]     = "",
    ["cv"]    = "",
    ["ce"]    = "",
    ["r"]     = "﯒",
    ["rm"]    = "﯒",
    ["r?"]    = "﯒",
    ["!"]     = "",
    ["t"]     = "",
}

M.gitstatus_icons = {
    -- Change type
    added          = "", -- NOTE: you can set any of these to an empty string to not show them
    deleted        = "",
    modified       = "",
    renamed        = "",
    -- Status type
    untracked      = "◌",
    ignored        = "",
    unstaged       = "",
    staged         = "",
    conflict       = "",
}

M.filetype_icons       = {
    NvimTree           = "פּ ",
    ["neo-tree"]       = "פּ ",
    ["neo-tree-popup"] = "פּ ",
    help               = "ﲉ ",
    toggleterm         = " ",
    Outline            = " ",
    lazy               = " ",
    dapui_watches      = " ",
    dapui_config       = " ",
    dapui_scopes       = " ",
    dapui_breakpoints  = " ",
    ["dap-repl"]       = " ",
    dapui_console      = " ",
    dapui_stacks       = " ",
    default            = " ",
    TelescopePrompt    = " ",
    dashboard          = " ",
    Lazygit            = " ",
    mason              = " ",
    spectre            = " ",
    spectre_panel      = " ",
}
-- stylua: ignore end

return M
