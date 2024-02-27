local s = 0
return {
    init = function(self)
        self.clients = {}
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        for _, client in pairs(clients) do
            table.insert(self.clients, client.name)
        end
    end,
    provider = function(self)
        return table.concat(self.clients, ",")
    end,
    update = { "LspAttach", "LspDetach", "WinEnter", "BufEnter", "BufLeave", "WinLeave" },
}
