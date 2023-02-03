return {
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
}
