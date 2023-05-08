return {
    "lambdalisue/suda.vim",
    -- bufread = true,
    event = { "BufReadCmd", "FileReadCmd", "BufWriteCmd", "FileWriteCmd" },
    -- cmd = { "SudaWrite", "SudaRead" },
    init = function()
        vim.g.suda_smart_edit = 1
    end,
}
