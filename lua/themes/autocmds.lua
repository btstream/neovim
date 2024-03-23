local set_hl = require("themes.colors.manager").set_hl

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        require("themes.colors.manager").update()
        require("themes.colors.highlights").set()
    end,
})

vim.api.nvim_create_autocmd({ "WinEnter", "FileType" }, {
    -- pattern = "*",
    callback = function(event)
        local colors = require("themes.colors.manager").colors()
        local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })

        if filetype == "neo-tree" then
            local highlights = {}
            set_hl({
                NvimTreeSidebarTitle = { bg = colors.base00, fg = colors.base0D },
                OutlineSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                NeoTreeTabActive = { bg = colors.base00, fg = colors.base0D },
            })
            vim.schedule(function()
                local source = vim.api.nvim_buf_get_var(event.buf, "neo_tree_source")
                -- local source = vim.bo[0].neo_tree_source
                if source == "filesystem" then
                    highlights = vim.tbl_extend("keep", highlights, {
                        EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base0D },
                        EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base03 },
                        EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base03 },
                    })
                end
                if source == "buffers" then
                    highlights = vim.tbl_extend("keep", highlights, {
                        EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base03 },
                        EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base0D },
                        EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base03 },
                    })
                end
                if source == "git_status" then
                    highlights = vim.tbl_extend("keep", highlights, {
                        EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base03 },
                        EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base03 },
                        EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base0D },
                    })
                end
                set_hl(highlights)
            end)
            -- disable outline config
        elseif filetype == "Outline" then
            set_hl({
                NvimTreeSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                OutlineSidebarTitle = { bg = colors.base00, fg = colors.base0D },
                NeoTreeTabActive = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base03 },
            })
        elseif filetype ~= "notify" then
            set_hl({
                NvimTreeSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                OutlineSidebarTitle = { bg = colors.base00, fg = colors.base03 },
                NeoTreeTabActive = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeFilesystem = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeBuffers = { bg = colors.base00, fg = colors.base03 },
                EdgyTitleNeoTreeGit = { bg = colors.base00, fg = colors.base03 },
            })
        end
    end,
})
