return {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    enabled = false,
    config = function(_, opts)
        local icons = require("themes.icons").filetype_icons
        require("dressing").setup(vim.tbl_extend("keep", opts, {
            input = {
                -- Set to false to disable the vim.ui.input implementation
                enabled = false,

                -- Default prompt string
                default_prompt = " Input: ",

                -- Can be 'left', 'right', or 'center'
                prompt_align = "center",

                -- When true, <Esc> will close the modal
                insert_only = true,

                -- When true, input will start in insert mode.
                start_in_insert = true,

                -- These are passed to nvim_open_win
                -- anchor = "SW",
                border = "rounded",
                -- 'editor' and 'win' will default to being centered
                relative = "editor",

                -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                prefer_width = 30,
                width = nil,
                -- min_width and max_width can be a list of mixed types.
                -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
                max_width = { 140, 0.9 },
                min_width = { 20, 0.2 },

                -- Window transparency (0-100)
                win_options = {
                    winblend = 5,
                    -- Change default highlight groups (see :help winhl)
                    winhighlight =
                    "NormalFloat:InputUIFloatWinNormal,FloatBorder:InputUIFloatBorder,FloatTitle:InputUIFloatTitle",
                },

                -- Set to `false` to disable
                mappings = {
                    n = {
                        ["<Esc>"] = "Close",
                        ["<CR>"] = "Confirm",
                    },
                    i = {
                        ["<C-c>"] = "Close",
                        ["<CR>"] = "Confirm",
                        ["<Up>"] = "HistoryPrev",
                        ["<Down>"] = "HistoryNext",
                    },
                },

                override = function(conf)
                    -- This is the config that will be passed to nvim_open_win.
                    -- Change values here to customize the layout
                    return conf
                end,

                -- see :help dressing_get_config
                get_config = function(opts)
                    if opts.prompt == "New Name: " then
                        opts.prompt = " 󰑕 New name "
                        return {
                            relative = "cursor",
                            win_options = {
                                winhighlight =
                                "NormalFloat:LspFloatWinNormal,FloatBorder:LspWinRenameBorder,FloatTitle:LspWinRenameTitle",
                            },
                        }
                    end

                    if opts.prompt:match("^Neo%-tree Popup.*") then
                        opts.prompt = opts.prompt:gsub("^Neo%-tree Popup\n(.*)\n", " " .. icons["neo-tree"] .. " %1 ")
                        return {
                            relative = "cursor",
                        }
                    end
                end,
            },
            select = {
                -- Set to false to disable the vim.ui.select implementation
                enabled = true,

                -- Priority list of preferred vim.select implementations
                backend = "nui",
                -- backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },

                -- Trim trailing `:` from prompt
                trim_prompt = true,

                -- Options for telescope selector
                -- These are passed into the telescope picker directly. Can be used like:
                -- telescope = require('telescope.themes').get_ivy({...})
                -- telescope = require("telescope.themes").get_cursor(),

                -- Options for nui Menu
                nui = {
                    position = {
                        row = 2,
                        col = 3,
                    },
                    size = nil,
                    relative = "cursor",
                    border = {
                        style = "rounded",
                    },
                    buf_options = {
                        swapfile = false,
                        filetype = "DressingSelect",
                    },
                    win_options = {
                        winblend = 5,
                        winhighlight =
                        "NormalFloat:SelectUIFloatWinNormal,FloatBorder:SelectUIFloatBorder,FloatTitle:SelectUIFloatTitle",
                    },
                    max_width = 320,
                    max_height = 40,
                    min_width = 40,
                    min_height = 10,
                },

                -- Used to override format_item. See :help dressing-format
                format_item_override = {},

                -- see :help dressing_get_config
                get_config = function(opts)
                    if opts.kind == "codeaction" then
                        opts.prompt = "  Code Action "
                        return {
                            nui = {
                                relative = "cursor",
                                win_options = {
                                    winhighlight =
                                    "NormalFloat:LspFloatWinNormal,FloatBorder:LspWinCodeActionBorder,FloatTitle:LspWinCodeActionTitle",
                                },
                            },
                        }
                    end

                    if opts.prompt == "Load Session" or opts.prompt == "Delete Session" then
                        return {
                            backend = "telescope",
                        }
                    end
                end,
            },
        }))
    end,
}
