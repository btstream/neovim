return {
    "s1n7ax/nvim-comment-frame",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-comment-frame").setup({
            keymap = "<leader>cc",
            multiline_keymap = "<leader>cC",
        })
    end,
    keys = require("keymaps")["nvim-comment-frame"].lazy_keys(),
}
