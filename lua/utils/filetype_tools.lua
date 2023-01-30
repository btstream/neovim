local M = {}

M._nonefiletypes = {
    "TelescopePrompt",
    "TelescopePreview",
    "dashboard",
    "lsp-installer",
    "lspinfo",
    "mason",
    "packer",
    "Outline",
    "NvimTree",
    "neo-tree",
    "neo-tree-popup",
    "help",
    "Trouble",
    "dapui_breakpoints",
    "dapui_scopes",
    "dap-repl",
    "dapui_console",
    "lazy",
    "spectre",
    "spectre_panel",
    "directory",
}

-- stylua: ignore
M._icons = {
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

local function add_none_filetype(ft)
    if not vim.tbl_contains(M._nonefiletypes, ft) then
        table.insert(M._nonefiletypes, ft)
    end
end

for key, _ in pairs(M._icons) do
    add_none_filetype(key)
end

M.add_none_filetypes = function(types)
    for _, value in ipairs(types) do
        if type(value) == "string" then
            if not vim.tbl_contains(M._nonefiletypes, value) then
                table.insert(M._nonefiletypes, value)
            end
        elseif type(value) == "table" then
            assert(#value ~= 2, "Format error, must in format of {'filetype', icon = ''}")
            assert(type(value.icon) ~= "string", "Format error, icon key must be a string")
            M._icons[value[1]] = value.icon
            table.insert(M._nonefiletypes, value[1])
        end
    end
end

M.is_nonefiletype = function()
    local filetype = vim.bo.filetype
    local isdir = vim.fn.isdirectory(vim.fn.expand("%:p")) == 1
    return vim.tbl_contains(M._nonefiletypes, filetype) or M._icons[filetype] ~= nil or isdir, filetype
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
    -- local nft = {}
    -- for k, _ in pairs(M._icons) do
    --     table.insert(nft, k)
    -- end
    -- vim.tbl_deep_extend("keep", nft, M._nonefiletypes)
    -- return nft
    return M._nonefiletypes
end

return M
