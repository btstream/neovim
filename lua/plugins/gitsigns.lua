-- TODO:fix keymap
return {
    "lewis6991/gitsigns.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "User BufReadRealFilePost",
    config = function()
        local popup = require("gitsigns.popup")
        local orig_popup = popup.create

        popup.create = function(lines_spec, opts, id)
            local winid, _ = orig_popup(lines_spec, opts, id)
            vim.api.nvim_win_set_option(
                winid,
                "winhighlight",
                "NormalFloat:GitSignHunkPreviewNormal,FloatBorder:GitSignHunkPreviewBorder"
            )
        end

        require("gitsigns").setup({
            signs = {
                untracked = {
                    hl = "GitSignsUntracked",
                    text = "┃",
                    numhl = "GitSignsUntrackedNr",
                    linehl = "GitSignsUntrackedLn",
                },
            },
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 200,
                ignore_whitespace = false,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
            preview_config = {
                -- Options passed to nvim_open_win
                border = "rounded",
                style = "minimal",
                relative = "cursor",
                row = 0,
                col = 1,
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        return "]c"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })

                map("n", "[c", function()
                    if vim.wo.diff then
                        return "[c"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true })
            end,
        })
    end,
}
