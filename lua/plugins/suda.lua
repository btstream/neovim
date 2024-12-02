return {
    "lambdalisue/suda.vim",
    event = { "BufReadPre", "BufNew" },
    init = function()
        vim.g.suda_smart_edit = 1
    end,
}
