return {
    "NTBBloodbath/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "http",
    config = function()
        require("plugins.settings.rest_nvim")
    end,
}
