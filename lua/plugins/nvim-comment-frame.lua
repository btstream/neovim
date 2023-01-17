return {
    "s1n7ax/nvim-comment-frame",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("plugins.settings.nvim_comment_frame")
    end,
    keys = { "<leader>cC", "<leader>cc", { mode = "i", "<C-k>c" }, { mode = "i", "<C-k>C" } },
}
