return {
    "danymat/neogen",
    config = function()
        require("neogen").setup({ enable = true })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
        {
            mode = "n",
            "<Leader>nf",
            "<cmd>lua require('neogen').generate()<CR>",
            desc = "generate docstr for function",
        },
        {
            mode = "n",
            "<Leader>nc",
            "<cmd>lua require('neogen').generate({type = 'class'})<CR>",
            desc = "generate docstr for class",
        },
    },
}
