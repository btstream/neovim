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
                require("plugins.neo-tree.utils").toggle()
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
                highlight = "IndentBlanklineChar",
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
                symbols = require("themes.icons").gitstatus_icons,
                align = "right",
            },
        },
        filesystem = {
            use_libuv_file_watcher = true,
            follow_current_file = true,
            hijack_netrw_behavior = "open_current",
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
                    local go_to = function(index)
                        return function()
                            require("plugins.neo-tree.utils").goto_source(index)
                        end
                    end

                    require("utils.keymap_tools").map({
                        { "n", "<A-1>", go_to(1) },
                        { "n", "<A-2>", go_to(2) },
                        { "n", "<A-3>", go_to(3) },
                        { "n", "<A-4>", go_to(4) },
                        { "n", "<A-5>", go_to(5) },
                        { "n", "<A-6>", go_to(6) },
                        { "n", "<A-7>", go_to(7) },
                        { "n", "<A-8>", go_to(8) },
                        { "n", "<A-9>", go_to(9) },
                        { "n", "<A-,>", '<cmd>lua require("plugins.neo-tree.utils").goto_previous_source()<CR>' },
                        { "n", "<A-.>", '<cmd>lua require("plugins.neo-tree.utils").goto_next_source()<CR>' },
                    })
                end,
            },
            {
                event = "neo_tree_buffer_leave",
                handler = function()
                    require("utils.keymap_tools").map({
                        { "n", "<A-,>", "<cmd>BufferLineCyclePrev<CR>" },
                        { "n", "<A-.>", "<cmd>BufferLineCycleNext<CR>" },
                        { "n", "<A-1>", "<cmd>BufferLineGoToBuffer 1<CR>" },
                        { "n", "<A-2>", "<cmd>BufferLineGoToBuffer 2<CR>" },
                        { "n", "<A-3>", "<cmd>BufferLineGoToBuffer 3<CR>" },
                        { "n", "<A-4>", "<cmd>BufferLineGoToBuffer 4<CR>" },
                        { "n", "<A-5>", "<cmd>BufferLineGoToBuffer 5<CR>" },
                        { "n", "<A-6>", "<cmd>BufferLineGoToBuffer 6<CR>" },
                        { "n", "<A-7>", "<cmd>BufferLineGoToBuffer 7<CR>" },
                        { "n", "<A-8>", "<cmd>BufferLineGoToBuffer 8<CR>" },
                        { "n", "<A-9>", "<cmd>BufferLineGoToBuffer 9<CR>" },
                    })
                end,
            },
        },
    },
}
