return {
    "nvim-tree/nvim-tree.lua",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VimEnter",
    -- cmd = "NvimTreeToggle",
    config = function()
        require("plugins.settings.nvim_tree")
    end,
}
