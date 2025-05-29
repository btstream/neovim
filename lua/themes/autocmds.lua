local set_hl = require("themes.colors.manager").set_hl

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        require("themes.colors.manager").update()
        require("themes.colors.highlights").set()
    end,
})

-- change colors when focus or lose focus on sidebar
vim.api.nvim_create_autocmd({ "WinEnter", "BufWinEnter", "WinEnter", "BufEnter" }, {
    callback = vim.schedule_wrap(function(event)
        local colors = require("themes.colors.manager").colors()
        local s, filetype = pcall(vim.api.nvim_get_option_value, "filetype", { buf = event.buf })
        if not s then
            return
        end

        if require("utils.filetype").is_nonefiletype(event.buf)
            or vim.fn.buflisted(event.buf) ~= 1
        then
            if filetype ~= "neo-tree" and filetype ~= "Outline" then
                return
            end
        end

        if filetype == "Outline" or filetype == "neo-tree" then
            set_hl({
                EdgySidebarLeftTitle = { bg = colors.base00, fg = colors.base0D },
                EdgySidebarRightTitle = { bg = colors.base00, fg = colors.base03 },
                NeoTreeTabActive = { bg = colors.base00, fg = colors.base0D },
            })
            if vim.g.sidebar_source == "filesystem" then
                set_hl({
                    EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base0D },
                    EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleOutline = { bg = colors.base00, fg = colors.base04 },
                })
            elseif vim.g.sidebar_source == "outline" then
                set_hl({
                    EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleOutline = { bg = colors.base00, fg = colors.base0D },
                })
            elseif vim.g.sidebar_source == "buffers" then
                set_hl({
                    EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base0D },
                    EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleOutline = { bg = colors.base00, fg = colors.base04 },
                })
            elseif vim.g.sidebar_source == "git_status" then
                set_hl({
                    EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base04 },
                    EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base0D },
                    EdgyTitleOutline = { bg = colors.base00, fg = colors.base04 },
                })
            end
        else
            set_hl({
                EdgySidebarLeftTitle = { bg = colors.base00, fg = colors.base03 },
                EdgySidebarRightTitle = { bg = colors.base00, fg = colors.base03 },
                NeoTreeTabActive = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleOutline = { bg = colors.base00, fg = colors.base03 },
            })
        end
    end)
})
