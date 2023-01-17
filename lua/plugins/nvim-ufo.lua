return {
    "kevinhwang91/nvim-ufo",
    enabled = true,
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    event = "User BufReadRealFile",
    config = function()
        require("ufo").setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        })
    end,
}
