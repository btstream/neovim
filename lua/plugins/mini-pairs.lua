return {
    "nvim-mini/mini.pairs",
    version = false,
    enabled = false,
    event = "User BufReadRealFilePost",
    config = function(_, opts)
        require("mini.pairs").setup(opts)
    end,
}
