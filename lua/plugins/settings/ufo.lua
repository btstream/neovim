-- require("utils.packer").ensure_loaded("nvim-treesitter")
require("ufo").setup({
    provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
    end,
})
