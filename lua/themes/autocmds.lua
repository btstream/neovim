local set_hl = require("themes.colors.manager").set_hl
local title = require("plugins.edgy.title")

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        require("themes.colors.manager").update()
        require("themes.colors.highlights").set()
    end,
})

-- change colors when focus or lose focus on sidebar
-- vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "WinEnter", "BufEnter", "ModeChanged" }, {
-- the groups below are read from the pane metadata (plugins.edgy.views), so
-- this stays in sync with the winbar without a second hardcoded list; the
-- table is empty until edgy has been loaded and set up
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter" }, {
    callback = vim.schedule_wrap(function(event)
        local ok, filetype = pcall(vim.api.nvim_get_option_value, "filetype", { buf = event.buf })
        if not ok then
            return
        end

        local sidebar_focused = filetype == "Outline" or filetype == "neo-tree"
        local ai_sidebar_focused = vim.startswith(filetype, "ade")
        if not sidebar_focused and not ai_sidebar_focused
            and (require("utils.filetype").is_nonefiletype(event.buf) or vim.fn.buflisted(event.buf) ~= 1)
        then
            return
        end

        local colors = require("themes.colors.manager").colors()
        local left_fg = sidebar_focused and colors.base0D or colors.base03
        local right_fg = ai_sidebar_focused and colors.base0D or colors.base03
        local highlights = {
            EdgySidebarLeftTitle = { bg = colors.base00, fg = left_fg },
            EdgySidebarRightTitle = { bg = colors.base00, fg = right_fg },
            NeoTreeTabActive = { bg = colors.base00, fg = left_fg },
        }

        local sidebar_title_groups = title.groups()
        local active_group = sidebar_focused and sidebar_title_groups[vim.g.sidebar_source]
        if not sidebar_focused or active_group then
            local inactive_fg = sidebar_focused and colors.base04 or colors.base03
            for _, group in pairs(sidebar_title_groups) do
                highlights[group] = {
                    bg = colors.base00,
                    fg = group == active_group and colors.base0D or inactive_fg,
                }
            end
        end

        set_hl(highlights)
    end)
})
