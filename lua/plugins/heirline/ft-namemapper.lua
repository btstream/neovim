local display_name = {
    snacks_picker_input = "snacks",
    snacks_dashboard    = "dashboard",
    snacks_diagnostics  = "diagnostics",
    snacks_terminal     = "terminal",
    terminal            = "terminal",
    dashboard           = "dashboard",
    ["lsp-installer"]   = "lsp-installer",
    lspinfo             = "lspinfo",
    mason               = "mason",
    packer              = "packer",
    Outline             = "Outline",
    NvimTree            = "NvimTree",
    ["neo-tree"]        = "neo-tree",
    ["neo-tree-popup"]  = "neo-tree",
    help                = "help",
    Trouble             = "trouble",
    dapui_breakpoints   = "breakpoints",
    dapui_scopes        = "scopes",
    ["dap-repl"]        = "repl",
    dapui_console       = "console",
    lazy                = "lazy",
    spectre             = "search & replace",
    spectre_panel       = "search & replace",
    directory           = "directory",
    cmdline             = "cmdline",
    noice               = "noice",
    dropbar_menu        = "dropbar_menu",
    edgy                = "edgy",
    Glance              = "Glance",
    ["grug-far"]        = "search & replace",
    opencode_terminal   = "opencode",
    opencode_ask        = "opencode"
}

return setmetatable({}, {
    __index = function(_, ft)
        return display_name[ft] or ft
    end
})
