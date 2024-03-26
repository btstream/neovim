return {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- enabled = false,
    dependencies = {
        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
        "MunifTanjim/nui.nvim",
        -- OPTIONAL:
        --   `nvim-notify` is only needed, if you want to use the notification view.
        --   If not available, we use `mini` as the fallback
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = {
            format = {
                cmdline = { pattern = "^:", icon = "  ", lang = "vim" },
                search_down = {
                    kind = "search",
                    pattern = "^/",
                    icon = require("themes.icons").common_ui_icons.search_result .. " ",
                    lang = "regex",
                },
                search_up = {
                    kind = "search",
                    pattern = "^%?",
                    icon = require("themes.icons").common_ui_icons.search_result .. " ",
                    lang = "regex",
                },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "  ", lang = "lua" },
                help = {
                    pattern = "^:%s*he?l?p?%s+",
                    icon = " " .. require("themes.icons").filetype_icons.help .. " ",
                },
            },
        },
        views = {
            confirm = {
                border = {
                    text = { top = " 󰬚 Confirm ", top_align = "center" },
                },
                win_options = {
                    winhighlight = {
                        Normal = "NoiceConfirm",
                        FloatBorder = "NoiceConfirmBorder",
                        FloatTitle = "NoiceConfirmTitle",
                    },
                },
            },
        },
        lsp = {
            progress = {
                enabled = true,
                format_done = {
                    { "󰄬 ", hl_group = "NoiceLspProgressSpinner" },
                    { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
                    { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
                },
            },
            -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
            -- disable signature, use cmp for signature help
            signature = {
                enabled = false,
            },
            documentation = {
                opts = {
                    border = {
                        text = { top = " 󰬋 Documentation ", top_align = "center" },
                    },
                    size = {
                        max_width = "80",
                    },
                    buf_options = {
                        filetype = "documentation",
                    },
                    win_options = {
                        winhighlight = {
                            NormalFloat = "LspWinHoverNormal",
                            FloatBorder = "LspWinHoverBorder",
                            FloatTitle = "LspWinHoverTitle",
                        },
                    },
                },
            },
        },
        -- you can enable a preset for easier configuration
        presets = {
            bottom_search = true, -- use a classic bottom cmdline for search
            command_palette = true, -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false, -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true, -- add a border to hover docs and signature help
        },
    },
    config = function(_, opts)
        local M = require("noice.lsp.progress")
        local orig = M.progress
        -- disable lsp progress messages for null-ls
        M.progress = function(data)
            local client = vim.lsp.get_client_by_id(data.client_id)
            local name = client.name

            if name == "null-ls" then
                return
            end
            orig(data)
        end

        require("noice").setup(opts)
    end,
}
