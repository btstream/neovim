return {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User BufReadRealFilePost",
    config = function(_, opts)
        local popup = require("gitsigns.popup")
        local orig_popup = popup.create

        popup.create = function(lines_spec, opts, id)
            local winid, _ = orig_popup(lines_spec, opts, id)
            vim.api.nvim_set_option_value(
                "winhighlight",
                "NormalFloat:GitSignHunkPreviewNormal,FloatBorder:GitSignHunkPreviewBorder",
                {
                    win = winid,
                }
            )
        end

        require("gitsigns").setup(vim.tbl_extend("keep", opts, {
            signs = {
                add = { text = "█" },
                change = { text = "█" },
                delete = { text = "▁" },
                topdelete = { text = "▔" },
                changedelete = { text = "↭" },
                untracked = {
                    -- hl = "GitSignsUntracked",
                    text = "█",
                    -- numhl = "GitSignsUntrackedNr",
                    -- linehl = "GitSignsUntrackedLn",
                },
            },
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                virt_text_priority = 5000,
                delay = 200,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "   <author>, <author_time:%Y-%m-%d> - <summary>  ",
            preview_config = {
                -- Options passed to nvim_open_win
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = function(buf)
                local gs = package.loaded.gitsigns

                if gs then
                    vim.keymap.set("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            package.loaded.gitsigns.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, buffer = buf })

                    vim.keymap.set("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            package.loaded.gitsigns.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true, buffer = buf })
                end
            end,
        }))
    end,
}
