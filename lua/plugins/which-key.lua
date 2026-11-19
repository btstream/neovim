return {
    "folke/which-key.nvim",
    event = { "User BufReadRealFilePost" },
    opts = {
        spec = {
            -- <C-k> tool prefix
            { "<C-k>b", desc = "Sidebar (Neo-tree)" },
            { "<C-k>o", desc = "Outline" },
            { "<C-k>z", desc = "Zen mode" },
            { "<C-k>p", desc = "Find files" },
            { "<C-k><C-p>", desc = "All pickers" },
            { "<C-k>s", desc = "Document symbols" },
            { "<C-k>S", desc = "Workspace symbols" },
            { "<C-k>r", desc = "Resume last picker" },
            { "<C-k>f", desc = "Search workspace" },
            { "<C-k>w", desc = "Search current word" },
            { "<C-k>t", desc = "Terminal" },
            { "<C-k>g", desc = "Lazygit" },
            { "<C-k>h", desc = "Find and replace" },
            { "<C-k>H", desc = "Find and replace (prefill word)" },
            { "<C-k>c", desc = "Single-line comment frame" },
            { "<C-k>C", desc = "Multi-line comment frame" },
            { "<C-k>d", desc = "TODO list" },
            { "<C-k>U", desc = "Update outdated plugins" },

            -- <leader> groups
            { "<leader>b", group = "Buffer" },
            { "<leader>c", group = "Comment frame" },
            { "<leader>d", group = "Debug (DAP)" },
            { "<leader>n", group = "Doc comments (Neogen)" },
            { "<leader>x", group = "Diagnostics" },
            { "<leader>M", group = "SSH mounts" },
        },
    },
}
