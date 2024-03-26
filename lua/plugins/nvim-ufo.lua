return {
    "kevinhwang91/nvim-ufo",
    enabled = true,
    dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
    event = "User BufReadRealFilePost",
    opts = {
        provider_selector = function(buf, filetype, buftype)
            return { "lsp", "indent" }
        end,
    },
}
