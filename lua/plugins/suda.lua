-- TODO:fix keymap
return {
    "lambdalisue/suda.vim",
    -- bufread = true,
    -- event = "VeryLazy",
    cmd = { "SudaWrite", "SudaRead" },
    config = function()
        vim.g.suda_smart_edit = 1
    end,
}
