local icons = require("themes.icons").common_ui_icons

local os_path = require("utils.os.path")
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
            mode = { "n", "i", "t" },
            "<C-k>b",
            function()
                require("plugins.neo-tree.utils").toggle()
            end,
            desc = "open sidebar",
        },
    },
    opts = function()
        -- ensure signs are defined
        if not package.preload["plugins.lsp.diagnostics"] then
            require("plugins.lsp.diagnostics")
        end
        return {
            use_popups_for_input = false,
            enable_refresh_on_write = false,
            open_files_do_not_replace_types = {
                -- Neo-tree matches both buftype and filetype. Keep its defaults
                -- and exclude special buffers even when their filetype varies.
                "terminal", "Trouble", "qf", "edgy",
                "nofile", "nowrite", "prompt", "quickfix", "help",
                -- Persistent panels, including ones that can use a normal buftype.
                "Outline", "ade_chat", "ade_input", "ade_team_input", "ade_team_watch",
                "gitsigns-blame", "gitsigns-diff", "dropbar_menu",
                "OverseerList", "OverseerOutput", "OverseerForm",
                "dap-repl", "dapui_console", "dapui_scopes", "dapui_watches",
                "dapui_stacks", "dapui_breakpoints",
                "snacks_terminal", "snacks_diagnostics", "snacks_dashboard",
                "opencode", "opencode_terminal", "opencode_output", "opencode_ask", "sidekick_terminal",
                "neo-tree-popup", "netrw", "grug-far", "spectre_panel", "lazy", "mason", "noice",
            },
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
            event_handlers = {
                {
                    event = "neo_tree_buffer_enter",
                    handler = function()
                        if vim.api.nvim_get_mode().mode:match("^[iR]") then
                            vim.cmd.stopinsert()
                        end
                    end,
                },
                {
                    event = "file_added",
                    handler = function(file)
                        if os_path.isdir(file) then
                            return
                        end
                        vim.cmd("e " .. file)
                    end
                }
            },
        }
    end,
}
