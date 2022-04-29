local lsp_status = require("lsp-status")
lsp_status.config({})

--- function to get active_lsps, comes from galaxyline
---@param msg string default message
---@param ignored_servers table ignored_servers
---@return string
local get_lsp_client = function(msg, ignored_servers)
    msg = msg or "No Active Lsp"
    ignored_servers = ignored_servers or {}

    local clients = vim.lsp.buf_get_clients()
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
    if active_lsp == "" then
        return ""
    end

    local progress = lsp_status.status_progress() .. " "
    if string.len(progress) > 1 then
        return progress
    else
        return active_lsp .. " "
    end
end

return lsp_progress
