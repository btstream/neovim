return {
    "echasnovski/mini.align",
    version = false,
    event = "User BufReadRealFilePost",
    config = function()
        require("mini.align").setup()
    end,
}
