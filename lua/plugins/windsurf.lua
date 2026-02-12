return {
    "Exafunction/windsurf.nvim",
    event = { "User BufReadRealFile" },
    enabled = false,
    config = function(_, opts)
        require("codeium").setup(vim.tbl_deep_extend("keep", opts, {
            enable_cmp_source = false,
        }))
    end,
}
