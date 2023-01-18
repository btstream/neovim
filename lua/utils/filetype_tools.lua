local M = {}

M._nonefiletypes = {
    "TelescopePrompt",
    "TelescopePreview",
    "dashboard",
    "lsp-installer",
    "packer",
    "Outline",
    "NvimTree",
    "neo-tree",
    "neo-tree-popup",
    "help",
    "lspinfo",
    "Trouble",
    "mason",
    "dapui_breakpoints",
    "dapui_scopes",
    "dap-repl",
    "dapui_console",
    "lazy",
    "spectre",
    "spectre_panel",
}

-- stylua: ignore
M._icons = {
    NvimTree          = "פּ ",
    ["neo-tree"]      = "פּ ",
    help              = "ﲉ ",
    toggleterm        = " ",
    Outline           = " ",
    lazy              = " ",
    dapui_watches     = " ",
    dapui_config      = " ",
    dapui_scopes      = " ",
    dapui_breakpoints = " ",
    ["dap-repl"]      = " ",
    dapui_console     = " ",
    dapui_stacks      = " ",
    default           = " ",
    TelescopePrompt   = " ",
    dashboard         = " ",
    Lazygit           = " ",
    mason             = " ",
    spectre           = " ",
    spectre_panel     = " ",
}

M.add_none_filetypes = function(types)
    for _, value in ipairs(types) do
        if type(value) == "string" then
            if not vim.tbl_contains(M._nonefiletypes, value) then
                M._nonefiletypes[#M._nonefiletypes + 1] = value
            end
        elseif type(value) == "table" then
            assert(#value ~= 2, "Format error, must in format of {'filetype', icon = ''}")
            assert(type(value.icon) ~= "string", "Format error, icon key must be a string")
            M._icons[value[1]] = value.icon
        end
    end
end

M.is_nonefiletype = function()
    local filetype = vim.bo.filetype
    return vim.tbl_contains(M._nonefiletypes, filetype) or M._icons[filetype] ~= nil, filetype
end

M.get_icon = function()
    local filetype = vim.bo.filetype
    return M._icons[filetype]
end

M.type = function()
    local filetype = vim.bo.filetype
    if filetype:upper() == "TOGGLETERM" then
        return "terminal"
    end

    if filetype:upper() == "TELESCOPEPROMPT" then
        return "telescope"
    end

    return filetype
end

M.get_nonfiletypes = function()
    local nft = {}
    vim.tbl_extend("force", nft, M._nonefiletypes)
    for k, _ in pairs(M._icons) do
        table.insert(nft, k)
    end
    return nft
end

return M
