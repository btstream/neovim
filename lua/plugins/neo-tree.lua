return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    cmd = "NeoTreeShowToggle",
    opts = {
        window = {
            mappings = {
                ["<space>"] = "none",
            },
        },
        source_selector = {
            winbar = true,
        },
    },
}
