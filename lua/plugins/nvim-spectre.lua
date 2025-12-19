return {
    "windwp/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    enabled = false,
    keys = {
        {
            mode = { "n", "i" },
            "<C-k>h",
            function()
                require("spectre").toggle()
            end,
        },
    },
}
