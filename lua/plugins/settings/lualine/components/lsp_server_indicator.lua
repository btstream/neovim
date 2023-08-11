-- local lsp_status = require("lsp-status")
-- local filetype_tools = require("utils.filetype_tools")
-- lsp_status.config({})

--- function to get active_lsps, comes from galaxyline
---@param msg string default message
---@param ignored_servers table ignored_servers
---@return string
local get_lsp_client = function(msg, ignored_servers)
    msg = msg or "No Active Lsp"
    ignored_servers = ignored_servers or {}

    local clients = vim.lsp.get_clients({ bufnr = 0 }) --vim.lsp.buf_get_clients()
    if next(clients) == nil then
        return msg
    end

    local client_names = ""
    for _, client in pairs(clients) do
        if not vim.tbl_contains(ignored_servers, client.name) then
            if string.len(client_names) < 1 then
                client_names = client_names .. client.name
            else
                client_names = client_names .. ", " .. client.name
            end
        end
    end
    return string.len(client_names) > 0 and client_names or msg
end

local function lsp_progress()
    -- local icon = ""
    local active_lsp = get_lsp_client("", { "null-ls" })
    local icon = "  "
    local has_active_lsp = true
    if active_lsp == "" then
        has_active_lsp = false
        icon = " "
        if vim.bo.filetype == "" then
            active_lsp = "plaintext"
        else
            active_lsp = vim.bo.filetype
        end
    end

    -- local progress = require("lsp-status").status_progress() .. " "
    -- if has_active_lsp and string.len(progress) > 1 then
    --     return progress
    -- else
    return icon .. active_lsp .. " "
    -- end
end

return lsp_progress
