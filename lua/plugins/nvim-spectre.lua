return {
    "windwp/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            mode = { "n", "i" },
            "<C-k>h",
            function()
                require("spectre").toggle()
                -- vim.defer_fn(function()
                --     vim.fn.setpos(".", { 0, 3, 0, 0 })
                -- end, 200)
            end,
        },
    },
    config = function()
        require("spectre").setup({
            open_cmd = "botright new",
        })
    end,
}
