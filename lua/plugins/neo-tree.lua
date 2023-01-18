return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    keys = {
        {
            mode = { "n", "i" },
            "<C-k>b",
            function()
                local source = "filesystem"
                local active_source = require("plugins.neo-tree.utils").get_active_source()
                if active_source then
                    source = active_source
                    vim.g.last_active_neotree_source = active_source
                else
                    if vim.g.last_active_neotree_source ~= nil then
                        source = vim.g.last_active_neotree_source
                    end
                end
                require("neo-tree").focus(source, true, true)
            end,
            desc = "open sidebar",
        },
    },
    opts = {
        enable_refresh_on_write = false,
        default_component_configs = {
            indent = {
                indent_size = 2,
                padding = 1, -- extra padding on left hand side
                -- indent guides
                with_markers = true,
                indent_marker = "│",
                last_indent_marker = "└",
                -- highlight = "NeoTreeIndentMarker",
                -- expander config, needed for nesting files
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                expander_collapsed = "",
                expander_expanded = "",
                -- expander_highlight = "NeoTreeExpander",
            },
            modified = {
                symbol = "M ",
            },
            git_status = {
                symbols = {
                    -- Change type
                    added = "", -- NOTE: you can set any of these to an empty string to not show them
                    deleted = "",
                    modified = "",
                    renamed = "",
                    -- Status type
                    untracked = "◌",
                    ignored = "",
                    unstaged = "",
                    staged = "",
                    conflict = "",
                },
                align = "right",
            },
        },
        filesystem = {
            use_libuv_file_watcher = true,
            follow_current_file = true,
        },
        window = {
            mappings = {
                ["<space>"] = "none",
            },
        },
        source_selector = {
            winbar = true,
            separator = nil,
        },
        event_handlers = {
            {
                event = "neo_tree_buffer_enter",
                handler = function()
                    local toggle = function(index)
                        return function()
                            require("plugins.neo-tree.utils").toggle(index)
                        end
                    end
                    local map = vim.keymap.set
                    map("n", "<A-1>", toggle(1))
                    map("n", "<A-2>", toggle(2))
                    map("n", "<A-3>", toggle(3))
                    map("n", "<A-4>", toggle(4))
                    map("n", "<A-5>", toggle(5))
                    map("n", "<A-6>", toggle(6))
                    map("n", "<A-7>", toggle(7))
                    map("n", "<A-8>", toggle(8))
                    map("n", "<A-9>", toggle(9))

                    map("n", "<A-,>", '<cmd>lua require("plugins.neo-tree.utils").toggle_previous()<CR>')
                    map("n", "<A-.>", '<cmd>lua require("plugins.neo-tree.utils").toggle_next()<CR>')
                end,
            },
            {
                event = "neo_tree_buffer_leave",
                handler = function()
                    local map = vim.keymap.set
                    map("n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>")
                    map("n", "<A-.>", "<cmd>BufferLineCycleNext<CR>")
                    map("n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>")
                    map("n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>")
                    map("n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>")
                    map("n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>")
                    map("n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>")
                    map("n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>")
                    map("n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>")
                    map("n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>")
                    map("n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>")
                end,
            },
        },
    },
}
