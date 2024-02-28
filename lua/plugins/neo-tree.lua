local icons = require("themes.icons").common_ui_icons
-- to fix does not follow cwd, when in some situations for lazy loading
-- TODO: inspect neo-tree's source, to make it work more effective
-- vim.api.nvim_create_autocmd("User", {
--     pattern = "LazyLoad",
--     callback = function(ev)
--         local plugin = ev.data
--         if plugin == "neo-tree.nvim" then
--             require("utils.task_scheduler").defer(function()
--                 local s, _ = require("plugins.neo-tree.utils").get_active_source()
--                 if s == "filesystem" then
--                     local state = require("neo-tree.sources.manager").get_state(s)
--                     local cwd = vim.fn.getcwd()
--                     if state.path ~= cwd then
--                         require("neo-tree.sources.filesystem").navigate(state, cwd)
--                     end
--                 end
--             end, 100)
--         end
--     end,
-- })

return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
    },
    -- keys = require("keymaps")["neo-tree"].lazy_keys(),
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
    opts = function()
        -- ensure signs are defined
        require("plugins.lsp.diagostics")
        return {
            use_popups_for_input = false,
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
                icon = {
                    folder_closed = icons.folder_closed,
                    folder_open = icons.folder_open,
                    folder_empty = icons.folder_empty,
                    folder_empty_open = icons.folder_empty_open,
                },
                modified = {
                    symbol = "󰰏 ",
                },
                git_status = {
                    symbols = require("themes.icons").gitstatus_icons,
                    align = "right",
                },
            },
            filesystem = {
                use_libuv_file_watcher = true,
                follow_current_file = { enabled = true },
                hijack_netrw_behavior = "open_current",
                display_name = icons.file_explorer .. " Files",
            },
            buffers = {
                display_name = icons.buffers .. " Buffers",
            },
            git_status = {
                display_name = icons.git .. " Git",
            },
            window = {
                mappings = {
                    ["<space>"] = "none",
                },
            },
            source_selector = {
                winbar = false,
                separator = nil,
            },
            -- event_handlers = {
            --     {
            --         event = "neo_tree_buffer_enter",
            --         handler = function()
            --             require("keymaps")["neo-tree"].set(nil, true)
            --             -- vim.schedule(function() end)
            --         end,
            --     },
            --     {
            --         event = "neo_tree_buffer_leave",
            --         handler = function()
            --             require("keymaps").bufferline.set(nil, true)
            --             -- require("utils.keymap_tools").map(require("keymaps").bufferline)
            --         end,
            --     },
            -- },
        }
    end,
}
