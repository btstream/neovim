return {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    dependencies = "neovim/nvim-lspconfig",
    config = function()
        local navic_icons = {}
        for k, v in ipairs(require("themes.icons").lsp_symbol_icons) do
            navic_icons[k] = (" %s "):format(v)
        end
        vim.g.navic_loaded = true
        require("nvim-navic").setup({
            highlight = true,
            separator = " › ",
            icons = navic_icons,
        })
    end,
}
