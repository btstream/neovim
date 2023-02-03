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
                    require("utils.keymap_tools").map(require("keymaps")["neo-tree"])
                end,
            },
            {
                event = "neo_tree_buffer_leave",
                handler = function()
                    require("utils.keymap_tools").map(require("keymaps").bufferline)
                end,
            },
        },
    },
}
