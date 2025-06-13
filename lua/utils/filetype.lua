local M = {}

M._nonefiletypes = {
    "TelescopePrompt",
    "TelescopePreview",
    "snacks_picker_input",
    "snacks_dashboard",
    "snacks_diagnostics",
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
    "cmdline",
    "noice",
    "dropbar_menu",
    "edgy",
    "Glance",
    "codecompanion",
    "Avante",
    "AvanteInput",
    "AvanteSelectedFiles",
    "aider"
}

M._icons = require("themes.icons").filetype_icons

local function add_none_filetype(ft)
    if not vim.tbl_contains(M._nonefiletypes, ft) then
        table.insert(M._nonefiletypes, ft)
    end
end

for key, _ in pairs(M._icons) do
    add_none_filetype(key)
end

function M.add_none_filetypes(types)
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

function M.is_nonefiletype(buf)
    local filetype = buf and vim.bo[buf].filetype or M.current_buf_type()
    local isdir = vim.fn.isdirectory(vim.fn.expand("%:p")) == 1
    return vim.tbl_contains(M._nonefiletypes, filetype) or M._icons[filetype] ~= nil or isdir, filetype
end

function M.get_icon()
    local filetype = M.current_buf_type()
    return M._icons[filetype]
end

function M.current_buf_type()
    local filetype = vim.bo[0].filetype
    return filetype
end

function M.get_nonfiletypes()
    -- local nft = {}
    -- for k, _ in pairs(M._icons) do
    --     table.insert(nft, k)
    -- end
    -- vim.tbl_deep_extend("keep", nft, M._nonefiletypes)
    -- return nft
    return M._nonefiletypes
end

return M
