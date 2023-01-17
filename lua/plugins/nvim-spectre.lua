return {
    "windwp/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("spectre").setup()
    end,
}
