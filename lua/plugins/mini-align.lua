return {
    "echasnovski/mini.align",
    version = false,
    event = "User BufReadRealFilePost",
    config = function(_, opts)
        require("mini.align").setup(opts)
    end,
}
