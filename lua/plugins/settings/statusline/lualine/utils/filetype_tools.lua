local M = {}

M._nonefiletypes = {
    "NVIMTREE",
    "TERMINAL",
    "DASHBOARD",
    "TOGGLETERM",
    "PACKER",
    "TELESCOPEPROMPT",
}

-- stylua: ignore
M._icons = {
    NVIMTREE          = "פּ ",
    HELP              = "ﲉ ",
    TOGGLETERM        = " ",
    OUTLINE           = " ",
    PACKER            = " ",
    DAPUI_WATCHES     = " ",
    DAPUI_CONFIG      = " ",
    DAPUI_SCOPES      = " ",
    DAPUI_BREAKPOINTS = " ",
    -- ["DAP-REPL"]     = " ",
    DAPUI_STACKS      = " ",
    DEFALT            = " ",
    TELESCOPEPROMPT   = " ",
    DASHBOARD         = " ",
    LAZYGIT           = " ",
    ["LSP-INSTALLER"] = " ",
}

M.add_none_filetypes = function(types)
    for _, value in ipairs(types) do
        if type(value) == "string" then
            if not vim.tbl_contains(M._nonefiletypes, value:upper()) then
                M._nonefiletypes[#M._nonefiletypes + 1] = value:upper()
            end
        elseif type(value) == "table" then
            assert(#value ~= 2, "Format error, must in format of {'filetype', icon = ''}")
            assert(type(value.icon) ~= "string", "Format error, icon key must be a string")
            M._icons[value[1]] = value.icon
        end
    end
end

M.is_nonefiletype = function()
    local filetype = vim.bo.filetype:upper()
    return vim.tbl_contains(M._nonefiletypes, filetype) or M._icons[filetype] ~= nil, filetype
end

M.get_icon = function()
    local filetype = vim.bo.filetype:upper()
    return M._icons[filetype]
end

return M
