return {
    { "<leader>cC" },
    { "<leader>cc" },
    {
        mode = "i",
        "<C-k>c",
        function()
            require("nvim-comment-frame").add_comment()
        end,
        desc = "add single line comment frame",
    },
    {
        mode = "i",
        "<C-k>C",
        function()
            require("nvim-comment-frame").add_multiline_comment()
        end,
        desc = "add multiple line comment frame",
    },
}
