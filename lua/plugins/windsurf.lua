return {
    "Exafunction/windsurf.nvim",
    event = { "User BufReadRealFile" },
    config = function(_, opts)
        require("codeium").setup(vim.tbl_deep_extend("keep", opts, {}))
    end,
}
