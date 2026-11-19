local icons = require("themes.icons").common_ui_icons

return {
    "folke/which-key.nvim",
    event = { "User BufReadRealFilePost" },
    opts = {
        spec = {
            -- <C-k> tool prefix
            { "<C-k>b", desc = "Sidebar (Neo-tree)", icon = { icon = icons.file_explorer, color = "cyan" } },
            { "<C-k>o", desc = "Outline" },
            { "<C-k>z", desc = "Zen mode", icon = { icon = "󰒲 ", color = "azure" } },
            { "<C-k>p", desc = "Find files", icon = { icon = "󰈞 ", color = "green" } },
            { "<C-k><C-p>", desc = "All pickers" },
            { "<C-k>s", desc = "Document symbols" },
            { "<C-k>S", desc = "Workspace symbols" },
            { "<C-k>r", desc = "Resume last picker" },
            { "<C-k>f", desc = "Search workspace", icon = { icon = icons.search_result, color = "green" } },
            { "<C-k>w", desc = "Search current word" },
            { "<C-k>t", desc = "Terminal", icon = { icon = "󰆍 ", color = "red" } },
            { "<C-k>g", desc = "Lazygit", icon = { icon = icons.git, color = "orange" } },
            { "<C-k>h", desc = "Find and replace" },
            { "<C-k>H", desc = "Find and replace (prefill word)" },
            { "<C-k>c", desc = "Single-line comment frame" },
            { "<C-k>C", desc = "Multi-line comment frame" },
            { "<C-k>d", desc = "TODO list" },
            { "<C-k>U", desc = "Update outdated plugins" },

            -- <leader> groups
            { "<leader>a", group = "AI (ade)", icon = { icon = "󰚩 ", color = "purple" } },
            { "<leader>b", group = "Buffer", icon = { icon = icons.buffers, color = "cyan" } },
            { "<leader>c", group = "Comment frame", icon = { icon = "󰆉 ", color = "grey" } },
            { "<leader>d", group = "Debug (DAP)", icon = { icon = "󰃤 ", color = "red" } },
            { "<leader>n", group = "Doc comments (Neogen)", icon = { icon = "󰆏 ", color = "blue" } },
            { "<leader>x", group = "Diagnostics", icon = { icon = "󱖫 ", color = "green" } },
            { "<leader>M", group = "SSH mounts", icon = { icon = "󰌘 ", color = "yellow" } },

            -- standalone mappings: icon only, desc comes from the mapping itself
            { "gd", icon = { icon = "󰈞 ", color = "cyan" } },
            { "gr", icon = { icon = "󰁦 ", color = "blue" } },
            { "gy", icon = { icon = "󰈞 ", color = "purple" } },
            { "<F5>", icon = { icon = "󰐊 ", color = "green" } },
        },
    },
}
