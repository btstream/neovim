local separator = require("plugins.heirline.components.separator")
local shared = require("plugins.heirline.components.shared")
local ft_namemapper = require("plugins.heirline.ft-namemapper")
local file_icon = require("plugins.heirline.components.file_icon")

local ft_indicator = {
    provider = function()
        local _, ft = shared.is_nonefiletype()
        return " " .. ft_namemapper[ft] .. " "
    end,
    condition = function()
        return shared.is_nonefiletype() and shared.current_buf_type() ~= "snacks_terminal"
    end,
}

local lsp_indicator = {
    init = function(self)
        self.clients = {}
        local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = 0 }) or vim.lsp.get_active_clients()
        for _, client in pairs(clients) do
            if client.name ~= "null-ls" then
                table.insert(self.clients, client.name)
            end
        end
    end,
    provider = function(self)
        local servers = table.concat(self.clients, ",")
        if #self.clients == 0 then
            return " " .. vim.bo.filetype .. " "
        end
        -- return " " .. servers .. " "
        return " " .. vim.bo.filetype .. " [" .. servers .. "] "
    end,
    condition = function()
        return not shared.is_nonefiletype()
    end,
}

return {
    hl = function()
        if shared.show_separators() then
            return { bg = "grey" }
        end
    end,
    separator({ block = true, char = separator.left_block }),
    ft_indicator,
    file_icon,
    lsp_indicator,
    update = shared.update.lsp,
}
