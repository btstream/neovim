return {
    "s1n7ax/nvim-comment-frame",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-comment-frame").setup({
            keymap = "<leader>cc",
            multiline_keymap = "<leader>cC",
        })
    end,
    keys = {
        "<leader>cC",
        "<leader>cc",
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
    },
}
