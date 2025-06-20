local icons = require("themes.icons")

return {
    "akinsho/bufferline.nvim",
    name = "bufferline",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "User BufReadRealFile",
    keys = require("keymaps").switch_tabs,
    config = function(_, opts)
        local termapp = require("utils.os.terminal")
        ---@diagnostic disable-next-line: undefined-field
        require("bufferline").setup(vim.tbl_extend("keep", opts, {
            options = {
                numbers = "ordinal",
                close_command = 'lua require("utils.window").quit(%d)',
                right_mouse_command = 'lua require("utils.window").quit(%d)',
                left_mouse_command = function(buf)
                    local current_buf = vim.api.nvim_win_get_buf(0)

                    -- pcall(function()
                    --     if package.loaded.glance then
                    --         require("glance").actions.close()
                    --     end
                    -- end)
                    --
                    ----------------------------------------------------------------------
                    --                       handle single click                        --
                    ----------------------------------------------------------------------
                    --- to prevent open buffer in terminal window
                    -- if require("lazy.core.config").plugins["toggleterm.nvim"]._.loaded then
                    --     local terms = require("toggleterm.terminal").get_all()
                    --
                    --     for _, t in pairs(terms) do
                    --         if t.bufnr == current_buf then
                    --             if t.direction == "float" then -- if float window, close it
                    --                 t:close()
                    --                 break
                    --             end
                    --         end
                    --     end
                    -- end

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
                end,
                middle_mouse_command = nil,
                indicator = {
                    style = (
                            termapp.is_fully_supported()
                            and (vim.fn.has("win32") ~= 1 and vim.fn.has("wsl") ~= 1)
                        )
                        and "underline"
                        or "icon",
                    icon = "▎ ",
                    -- icon = "▍",
                },
                modified_icon = "",
                close_icon = "",
                left_trunc_marker = "",
                right_trunc_marker = "",
                name_formatter = function(buf)
                    if buf.name:match("%.md") then
                        return vim.fn.fnamemodify(buf.name, ":t:r")
                    end
                end,
                max_name_length = 18,
                max_prefix_length = 15,
                tab_size = 18,
                diagnostics = "nvim_lsp",
                diagnostics_update_in_insert = false,
                ---@diagnostic disable-next-line: unused-local
                diagnostics_indicator = function(count, level, diagnostics_dict, context)
                    return "(" .. count .. ")"
                end,
                custom_filter = function(buf_number)
                    -- do not display dap-repl buffers
                    if vim.bo[buf_number].filetype ~= "dap-repl" and vim.bo[buf_number] ~= "spectre" then
                        return true
                    end
                end,
                show_buffer_icons = true, -- disable filetype icons for buffers
                show_buffer_close_icons = true,
                show_close_icon = false,
                show_tab_indicators = true,
                persist_buffer_sort = true,
                separator_style = { "", "" }, -- "slant" | "thick" | "thin" | { 'any', 'any' },
                enforce_regular_tabs = false,
                always_show_bufferline = true,
                sort_by = "id",
                -- themable = true,
            },
            ---@diagnostic disable-next-line: different-requires
            highlights = require("themes.bufferline"),
        }))

        local Offset = require("bufferline.offset")
        if not Offset.edgy then
            local get = Offset.get
            Offset.get = function()
                if package.loaded.edgy then
                    local layout = require("edgy.config").layout
                    local ret = { left = "", left_size = 0, right = "", right_size = 0 }
                    for _, pos in pairs({ "left", "right" }) do
                        local sb = layout[pos]
                        local title = (pos == "left" and icons.common_ui_icons.sidebar_left or icons.common_ui_icons.sidebar_right)
                            .. (pos == "left" and " Sidebar " or " Aider")
                        local sep = pos == "left" and "▍" or "🮈"
                        local hi = pos == "left" and "EdgySidebarLeftTitle" or "EdgySidebarRightTitle"
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
