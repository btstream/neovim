return {
    "danymat/neogen",
    config = function()
        require("neogen").setup({ enable = true })
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = require("utils.keymap_tools").to_lazy_key(require("keymaps").neogen),
}
