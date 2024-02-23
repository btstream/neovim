return {
    "rebelot/heirline.nvim",
    dependencies = { "Zeioth/heirline-components.nvim" },
    config = function()
        require("plugins.settings.heirline")
    end,
}
