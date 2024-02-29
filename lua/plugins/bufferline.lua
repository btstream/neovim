return {
    "akinsho/bufferline.nvim",
    name = "bufferline",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "User BufReadRealFile",
    keys = function()
        local nonfiletypes = require("utils.filetype").get_nonfiletypes()
        local function go_to_tab(index)
            return function()
                local config = require("bufferline.config")
                local list = require("bufferline.state").visible_components
                local element = list[index]
                if index == -1 or not element then
                    element = list[#list]
                end

                if vim.tbl_contains(nonfiletypes, vim.api.nvim_get_option_value("filetype", { buf = 0 })) then
                    local windows = vim.api.nvim_tabpage_list_wins(0)
                    for _, w in pairs(windows) do
                        local buf_in_w = vim.api.nvim_win_get_buf(w)

                        -- find first normal window contains a normal file
                        if
                            not vim.tbl_contains(
                                nonfiletypes,
                                vim.api.nvim_get_option_value("filetype", { buf = buf_in_w })
                            )
                        then
                            if element then
                                if config:is_tabline() and vim.api.nvim_tabpage_is_valid(element.id) then
                                    vim.api.nvim_set_current_tabpage(element.id)
                                elseif vim.api.nvim_buf_is_valid(element.id) then
                                    vim.api.nvim_win_set_buf(w, element.id)
                                end
                            end
                            return
                        end
                    end
                else
                    vim.api.nvim_win_set_buf(0, element.id)
                end
            end
        end

        return {
            { "<A-,>", "<cmd>BufferLineCyclePrev<CR>" },
            { "<A-.>", "<cmd>BufferLineCycleNext<CR>" },
            { "<A-1>", go_to_tab(1) },
            { "<A-2>", go_to_tab(2) },
            { "<A-3>", go_to_tab(3) },
            { "<A-4>", go_to_tab(4) },
            { "<A-5>", go_to_tab(5) },
            { "<A-6>", go_to_tab(6) },
            { "<A-7>", go_to_tab(7) },
            { "<A-8>", go_to_tab(8) },
            { "<A-9>", go_to_tab(9) },
            { "<Space>pp", "<cmd>BufferLinePick<CR>" },
            { mode = { "n", "i" }, "<A-w>", require("base.quit-behave").quit },
            {
                mode = { "n", "i" },
                "<C-k>b",
                function()
                    require("plugins.neo-tree.utils").toggle()
                end,
                desc = "open sidebar",
            },
        }
    end,
    config = function()
        require("bufferline").setup({
            options = {
                numbers = "ordinal", -- "none" | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
                --- @deprecated, please specify numbers as a function to customize the styling
                -- number_style = "superscript" | "subscript" | "" | { "none", "subscript" }, -- buffer_id at index 1, ordinal at index 2
                close_command = 'lua require("base.quit-behave").quit(%d)', --"bdelete! %d", -- can be a string | function, see "Mouse actions"
                right_mouse_command = 'lua require("base.quit-behave").quit(%d)', -- can be a string | function, see "Mouse actions"
                -- left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
                left_mouse_command = function(buf)
                    local current_buf = vim.api.nvim_win_get_buf(0)

                    ----------------------------------------------------------------------
                    --                       handle single click                        --
                    ----------------------------------------------------------------------
                    --- to prevent open buffer in terminal window
                    if require("lazy.core.config").plugins["toggleterm.nvim"]._.loaded then
                        local terms = require("toggleterm.terminal").get_all()

                        for _, t in pairs(terms) do
                            if t.bufnr == current_buf then
                                if t.direction == "float" then -- if float window, close it
                                    t:close()
                                    break
                                end
                            end
                        end
                    end

                    local nonfiletypes = require("utils.filetype").get_nonfiletypes()

                    --- first of all, if current window is a normal window (contains normal buffer in it)
                    --- then set target buffer to current window
                    local current_win = vim.api.nvim_get_current_win()
                    local current_win_buf = vim.api.nvim_win_get_buf(current_win)
                    if
                        not vim.tbl_contains(
                            nonfiletypes,
                            vim.api.nvim_get_option_value("filetype", { buf = current_win_buf })
                        )
                    then
                        vim.api.nvim_set_current_win(current_win)
                        vim.api.nvim_win_set_buf(current_win, buf)
                        return
                    end

                    --- if current window is not a normal window, then
                    --- find the first normal window, and set buffer to
                    --- that window
                    local windows = vim.api.nvim_tabpage_list_wins(0)
                    for _, w in pairs(windows) do
                        local buf_in_w = vim.api.nvim_win_get_buf(w)
                        if
                            current_buf ~= buf
                            and (
                                not vim.tbl_contains(
                                    nonfiletypes,
                                    vim.api.nvim_get_option_value("filetype", { buf = buf_in_w })
                                )
                            )
                        then
                            vim.api.nvim_set_current_win(w)
                            vim.api.nvim_win_set_buf(w, buf)
                            vim.cmd.stopinsert()
                            return
                        end
                    end

                    -- vim.cmd.buffer(bufnr)
                end,
                middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
                -- NOTE: this plugin is designed with this icon in mind,
                -- and so changing this is NOT recommended, this is intended
                -- -- as an escape hatch for people who cannot bear it for whatever reason
                -- indicator_icon = "▍ ",
                indicator = {
                    style = (
                        (os.getenv("TERM_PROGRAM") == "WezTerm" or os.getenv("TERM") == "xterm-kitty")
                        and (vim.fn.has("win32") ~= 1 and vim.fn.has("wsl") ~= 1)
                    )
                            and "underline"
                        or "icon",
                    icon = "▎ ",
                    -- icon = "▍",
                },
                -- buffer_close_icon = "",
                modified_icon = "",
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
                -- offsets = {
                -- {
                --     filetype = "neo-tree",
                --     text = function()
                --         return "  Sidebar"
                --         -- return require("plugins.neo-tree.utils").get_active_source_label()
                --     end,
                --     highlight = "NvimTreeSidebarTitle",
                --     text_align = "center",
                --     separator = "▍",
                --     -- padding = 1,
                -- },
                -- {
                --     filetype = "Outline",
                --     text = " Outline",
                --     highlight = "OutlineSidebarTitle",
                --     text_align = "center",
                --     separator = "🮈",
                -- },
                -- },
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
            highlights = require("themes.bufferline"),
        })

        local Offset = require("bufferline.offset")
        if not Offset.edgy then
            local get = Offset.get
            Offset.get = function()
                if package.loaded.edgy then
                    local layout = require("edgy.config").layout
                    local ret = { left = "", left_size = 0, right = "", right_size = 0 }
                    for _, pos in pairs({ "left", "right" }) do
                        local sb = layout[pos]
                        local title = pos == "left" and "  Sidebar" or " Outline"
                        local sep = pos == "left" and "▍" or "🮈"
                        local hi = pos == "left" and "NvimTreeSidebarTitle" or "OutlineSidebarTitle"
                        if sb and #sb.wins > 0 then
                            local is_even, side = (sb.bounds.width - #title) % 2 == 0, (sb.bounds.width - #title) / 2
                            local lpadding, rpadding = side, side
                            if not is_even then
                                lpadding, rpadding = math.ceil(side) + 1, math.floor(side) + 1
                            end
                            lpadding = pos == "right" and lpadding + 2 or lpadding
                            title = string.rep(" ", lpadding) .. title .. string.rep(" ", rpadding)
                            if pos == "left" then
                                ret[pos] = "%#"
                                    .. hi
                                    .. "#"
                                    .. title
                                    .. "%*"
                                    .. "%#BufferLineOffsetSeparator#"
                                    .. sep
                                    .. "%*"
                            else
                                ret[pos] = "%#BufferLineOffsetSeparator#"
                                    .. sep
                                    .. "%*"
                                    .. "%#"
                                    .. hi
                                    .. "#"
                                    .. title
                                    .. "%*"
                            end
                            ret[pos .. "_size"] = sb.bounds.width
                        end
                    end
                    ret.total_size = ret.left_size + ret.right_size
                    if ret.total_size > 0 then
                        return ret
                    end
                end
                return get()
            end
            Offset.edgy = true
        end
    end,
}
