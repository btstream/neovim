return {
    "windwp/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = require("keymaps")["nvim-spectre"].lazy_keys(),
    config = function()
        require("spectre").setup()
    end,
}
