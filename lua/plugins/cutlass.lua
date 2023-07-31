return {
    "gbprod/cutlass.nvim",
    event = "User BufReadRealFilePost",
    config = function()
        require("cutlass").setup({
            exclude = { "nx", "xx" },
        })
        vim.keymap.set("n", "xx", "dd", { noremap = true, silent = true })
    end,
}
