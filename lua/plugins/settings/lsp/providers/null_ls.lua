require("null-ls").setup({
    sources = {
        require("null-ls").builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
        }),
        require("null-ls").builtins.formatting.jq,
    },
})
