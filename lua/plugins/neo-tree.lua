return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = { { mode = { "n", "i" }, "<C-k>b", "<cmd>NeoTreeShowToggle<cr>", desc = "open sidebar" } },
    opts = {
        enable_refresh_on_write = false,
        filesystem = {
            use_libuv_file_watcher = true,
        },
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
