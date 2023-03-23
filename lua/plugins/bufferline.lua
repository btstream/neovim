return {
    "akinsho/bufferline.nvim",
    name = "bufferline",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- event = "User BufReadRealFile",
    event = { "BufReadPre", "BufNew" },
    config = function()
        require("bufferline").setup({
            options = {
                numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                --- @deprecated, please specify numbers as a function to customize the styling
                -- number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
                close_command = 'lua require("base.quit-behave").quit(%d)', --"bdelete! %d", -- can be a string | function, see "Mouse actions"
                right_mouse_command = 'lua require("base.quit-behave").quit(%d)', -- can be a string | function, see "Mouse actions"
                -- left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
                left_mouse_command = function(bufnr)
                    local current_buf = vim.api.nvim_win_get_buf(0)

                    -- handle double click
                    if current_buf == bufnr then
                        local key = string.format("tab_clicked_%s", bufnr)
                        if vim.g[key] == nil then
                            vim.g[key] = os.clock()
                            vim.defer_fn(function() -- clean timeout
                                vim.g[key] = nil
                            end, 300)
                        else
                            local timeout = os.clock() - vim.g[key]
                            if timeout < 0.3 then
                                if vim.g.saved_window then
                                    local winid = vim.api.nvim_get_current_win()

                                    if vim.g.saved_window.outline then
                                        vim.api.nvim_create_autocmd("User", {
                                            pattern = "OpenOutline",
                                            callback = function()
                                                vim.api.nvim_create_autocmd({ "BufEnter", "FileType" }, {
                                                    pattern = "*",
                                                    callback = function()
                                                        if vim.bo.filetype == "Outline" then
                                                            vim.api.nvim_set_current_win(winid)
                                                            vim.cmd.buffer(bufnr)
                                                            vim.cmd.stopinsert()
                                                        end
                                                        return true
                                                    end,
                                                })
                                                require("symbols-outline").toggle_outline()
                                                return true
                                            end,
                                        })
                                        if #vim.g.saved_window.term == 0 then
                                            vim.cmd("do User OpenOutline")
                                        end
                                    end

                                    for _, t in pairs(vim.g.saved_window.term) do
                                        local term = require("toggleterm.terminal").get(t)
                                        if not term:is_open() then
                                            local origianl_open = term.on_open
                                            term.on_open = function(t)
                                                origianl_open(t)
                                                vim.api.nvim_set_current_win(winid)
                                                vim.cmd.buffer(bufnr)
                                                vim.cmd.stopinsert()
                                                t.on_open = origianl_open
                                                vim.cmd("do User OpenOutline")
                                            end
                                            term:toggle()
                                        end
                                    end

                                    if vim.g.saved_window.neo_tree then
                                        vim.schedule(function()
                                            if not require("plugins.neo-tree.utils").get_active_source() then
                                                require("plugins.neo-tree.utils").toggle(false)
                                            end
                                        end)
                                    end

                                    vim.g.saved_window = nil
                                else
                                    local saved_window = {}

                                    -- if have buffer
                                    if require("plugins.neo-tree.utils").get_active_source() then
                                        require("plugins.neo-tree.utils").toggle(false)
                                        saved_window.neo_tree = true
                                    else
                                        saved_window.neo_tree = false
                                    end

                                    local terms = require("lazy.core.config").plugins["toggleterm.nvim"]._.loaded
                                            and require("toggleterm.terminal").get_all()
                                        or {}

                                    saved_window.term = {}
                                    for _, t in pairs(terms) do
                                        if t:is_open() then
                                            t:toggle()
                                            table.insert(saved_window.term, t.id)
                                        end
                                    end

                                    saved_window.outline = require("lazy.core.config").plugins["symbols-outline.nvim"]._.loaded
                                            and require("symbols-outline").view:is_open()
                                        or false

                                    if saved_window.outline then
                                        require("symbols-outline").toggle_outline()
                                    end

                                    vim.g.saved_window = saved_window
                                end
                                vim.g[key] = nil
                                return
                            end
                            vim.g[key] = nil
                        end
                    end

                    if require("lazy.core.config").plugins["toggleterm.nvim"]._.loaded then
                        local terms = require("toggleterm.terminal").get_all()

                        for _, t in pairs(terms) do
                            if t.bufnr == current_buf then
                                if t.direction == "float" then
                                    t:close()
                                    break
                                end
                            end
                        end
                    end

                    local windows = vim.api.nvim_tabpage_list_wins(0)
                    for _, w in pairs(windows) do
                        if vim.api.nvim_win_get_buf(w) == bufnr then
                            vim.api.nvim_set_current_win(w)
                            vim.cmd.buffer(bufnr)
                            vim.cmd.stopinsert()
                            break
                        end
                    end

                    vim.cmd.buffer(bufnr)
                end,
                middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                -- NOTE: this plugin is designed with this icon in mind,
                -- and so changing this is NOT recommended, this is intended
                -- -- as an escape hatch for people who cannot bear it for whatever reason
                -- indicator_icon = "▍ ",
                indicator = {
                    style = "icon",
                    icon = "▎ ",
                    -- icon = "▍",
                },
                buffer_close_icon = "",
                modified_icon = "●",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                --- name_formatter can be used to change the buffer's label in the bufferline.
                --- Please note some names can/will break the
                --- bufferline so use this at your discretion knowing that it has
                --- some limitations that will *NOT* be fixed.
                name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
                    -- remove extension from markdown files for example
                    if buf.name:match("%.md") then
                        return vim.fn.fnamemodify(buf.name, ":t:r")
                    end
                end,
                max_name_length = 18,
                max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
                tab_size = 18,
                diagnostics = "nvim_lsp", -- false | "nvim_lsp" | "coc",
                diagnostics_update_in_insert = false,
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end,
                custom_filter = function(buf_number)
                    -- do not display dap-repl buffers
                    if vim.bo[buf_number].filetype ~= "dap-repl" then
                        return true
                    end
                end,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = function()
                            -- return vim.fn.getcwd()
                            return "פּ File Explorer"
                        end,
                        highlight = "NvimTreeSidebarTitle",
                        text_align = "center",
                        separator = "▍",
                        -- padding = 1,
                    },
                    {
                        filetype = "neo-tree",
                        text = function()
                            -- return "פּ Sidebar"
                            return require("plugins.neo-tree.utils").get_active_source_label()
                        end,
                        highlight = "NvimTreeSidebarTitle",
                        text_align = "center",
                        separator = "▍",
                        -- padding = 1,
                    },
                    {
                        filetype = "Outline",
                        text = " Outline",
                        highlight = "OutlineSidebarTitle",
                        text_align = "center",
                        separator = "🮈",
                    },
                },
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,
                persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
                -- can also be a table containing 2 custom separators
                -- [focused and unfocused]. eg: { '|', '|' }
                separator_style = { "", "" }, -- "slant" | "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                sort_by = "id",
                -- themable = true,
            },
            highlights = require("themes.bufferline").highlights,
        })

        -- local map = vim.keymap.set

        -- Move to previous/next
        -- stylua: ignore
        -- require("utils.keymap_tools").map(require("keymaps").bufferline)
        require("keymaps").bufferline.set()
    end,
}
