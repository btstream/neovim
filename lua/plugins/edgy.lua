local icons = require("themes.icons")

local indicators = {
    "%*%#EdgyTitleNeoTreeFilesystem#" .. icons.common_ui_icons.file_explorer .. " ",
    "%*%#EdgyTitleOutline#" .. icons.common_ui_icons.symbols_outlne .. " ",
    "%*%#EdgyTitleNeoTreeBuffers#" .. icons.common_ui_icons.buffers .. " ",
    "%*%#EdgyTitleNeoTreeGit#" .. icons.common_ui_icons.git .. " "
}

vim.g.sidebar_source = ""
vim.g.sidebar_type = ""
vim.g.sidebar_title = ""

local function update_sidebar_title()
    local titles = vim.tbl_deep_extend("keep", {}, indicators)
    local active_index = 1

    local title_length = 8 + #vim.g.sidebar_source
    if vim.g.sidebar_source == "filesystem" then
        titles[1] = indicators[1] .. "Filesystem"
        active_index = 1
    elseif vim.g.sidebar_source == "outline" then
        titles[2] = indicators[2] .. "Outline"
        active_index = 2
    elseif vim.g.sidebar_source == "buffers" then
        titles[3] = indicators[3] .. "Buffers"
        active_index = 3
    elseif vim.g.sidebar_source == "git_status" then
        titles[4] = indicators[4] .. "Git Status"
        active_index = 4
    end


    local padding = ""
    if package.loaded.edgy then
        local sb = require("edgy.config").layout.left
        if sb and #sb.wins > 0 then
            padding = string.rep(" ", sb.bounds.width - title_length - 1)
        end
    end

    local active_indicator = table.remove(titles, active_index)
    table.insert(titles, 1, active_indicator)
    table.insert(titles, 2, padding)

    -- return table.concat(titles)
    vim.g.sidebar_title = table.concat(titles)
end

local function get_title()
    return vim.g.sidebar_title
end

return {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
        vim.opt.splitkeep = "screen"
        local siderbar_types = { "neo-tree", "Outline" }

        -- add auto command to allow only one window is opened on sidebar
        -- listen on BufWinEnter only
        vim.api.nvim_create_autocmd("BufWinEnter", {
            pattern = "*",
            callback = function(event)
                -- ensure edgy is loaded
                if package.loaded.edgy then
                    vim.schedule(function()
                        local current_ft = vim.fn.getbufvar(event.buf, "&filetype")
                        if vim.tbl_contains(siderbar_types, current_ft) then
                            local sidebar = require("edgy.config").layout.left
                            for _, win in ipairs(sidebar.wins) do
                                if current_ft == "Outline" and current_ft ~= win.view.ft then
                                    win:close()
                                end

                                if current_ft == "neo-tree" then
                                    local current_source = vim.api.nvim_buf_get_var(
                                        event.buf,
                                        "neo_tree_source"
                                    )
                                    if win.view.ft ~= current_ft then
                                        win:close()
                                    else
                                        local win_source = vim.api.nvim_buf_get_var(
                                            vim.api.nvim_win_get_buf(win.win),
                                            "neo_tree_source"
                                        )
                                        if current_source ~= win_source then
                                            win:close()
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end
        })

        vim.api.nvim_create_autocmd("BufEnter", {
            callback = vim.schedule_wrap(function(event)
                local ft = vim.fn.getbufvar(event.buf, "&filetype")
                if vim.tbl_contains(siderbar_types, ft) then
                    if ft == "Outline" then
                        vim.g.sidebar_source = "outline"
                        vim.g.sidebar_type = "Outline"
                    end

                    if ft == "neo-tree" then
                        vim.g.sidebar_type = "neo-tree"
                        vim.g.sidebar_source = vim.api.nvim_buf_get_var(event.buf, "neo_tree_source")
                    end

                    update_sidebar_title()
                end
            end)
        })
    end,
    opts = function()
        local opts = {
            animate = {
                enabled = false,
            },
            top = {
                {
                    ft = "help",
                    size = { height = 0.3 },
                    -- only show help buffers
                    filter = function(buf)
                        return vim.bo[buf].buftype == "help"
                    end,
                },
                { ft = "spectre_panel", title = "Search and Replace", size = { height = 0.3 } },
            },
            bottom = {
                -- toggleterm / lazyterm at the bottom with a height of 40% of the screen
                {
                    ft = "toggleterm",
                    size = { height = 0.25 },
                    title = "%*%#ToggleTermTitle#"
                        .. icons.filetype_icons.toggleterm
                        .. "[%{b:toggle_number}]:%{b:term_title}",
                    -- exclude floating windows
                    filter = function(_, win)
                        return vim.api.nvim_win_get_config(win).relative == ""
                    end,
                },
                "Trouble",
                {
                    ft = "lazyterm",
                    title = "LazyTerm",
                    size = { height = 0.4 },
                    filter = function(buf)
                        return not vim.b[buf].lazyterm_cmd
                    end,
                },
            },
            left = {
                -- Neo-tree filesystem always takes half the screen height
                {
                    title = get_title,
                    ft = "neo-tree",
                    filter = function(buf)
                        -- filter out filesystem's source for current position, which is uesed for hijack netrw
                        return vim.b[buf].neo_tree_source == "filesystem" and vim.b[buf].neo_tree_position ~= "current"
                    end,
                    open = "Neotree position=left filesystem",
                    size = { height = 0.5 },
                },
                {
                    title = get_title,
                    ft = "Outline",
                    -- pinned = true,
                    open = "Outline",
                },
                {
                    title = get_title,
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "buffers"
                    end,
                    -- pinned = true,
                    open = "Neotree position=top buffers",
                },
                {
                    title = get_title,
                    ft = "neo-tree",
                    filter = function(buf)
                        return vim.b[buf].neo_tree_source == "git_status"
                    end,
                    wo = {
                        winhighlight = "EdgyTitle:EdgyTitleNeoTreeGit",
                    },
                    -- pinned = true,
                    open = "Neotree position=right git_status",
                },
            },
            right = {
            },

            ----------------------------------------------------------------------
            --                             options                              --
            ----------------------------------------------------------------------
            options = {
                left = { size = 45 },
                bottom = { size = 10 },
                right = { size = 45 },
                top = { size = 10 },
            },
            close_when_all_hidden = false,
            icons = {
                -- closed = " ",
                -- open = " ",
                closed = "",
                open = "",
            },
            wo = {
                winhighlight = "WinBar:EdgyWinBar,Normal:Normal",
            },
        }

        return opts
    end,
}
