return {
    "Bekaboo/dropbar.nvim",
    event = "User BufReadRealFile",
    config = function()
        -- need to add space for each symbols
        local symbols = {}
        for key, value in pairs(require("themes.icons").lsp_symbols) do
            symbols[key] = string.format("%s ", value)
        end
        require("dropbar").setup({
            icons = {
                kinds = {
                    symbols = symbols,
                },
            },
        })
    end,
}
