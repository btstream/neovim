-- vim.cmd('colorscheme base16-material-darker')
vim.g.material_style = "darker"
-- vim.g.galaxyline_colorscheme = 'base16-material-darker'
vim.cmd("colorscheme material")
vim.cmd([[
" hi! link Visual CursorLine
" hi! link VertSplit CursorLine
" set fillchars+=vert:\ 
augroup themes
    autocmd!
    autocmd VimEnter * lua require('plugins.settings.themes').set_transparent()
    " autocmd colorscheme * hi! link VertSplit CursorLine
augroup end
]])

local M = {}
M.set_transparent = function()
    local enable = true
    if vim.g.GuiLoaded or vim.g.GUI == 1 then
        enable = false
    end
    require("transparent").setup({
        enable = enable, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be clear
            -- In particular, when you set it to 'all', that means all avaliable groups

            -- example of akinsho/nvim-bufferline.lua
            "BufferLineTabClose",
            "BufferlineBufferSelected",
            -- "BufferLineFill",
            -- "BufferLineBackground",
            -- "BufferLineSeparator",
            -- "BufferLineIndicatorSelected",
            "GitGutterAdd",
            "GitGutterDelete",
            "GitGutterChange",
            "NormalNC",
            "Terminal",
            "TelescopeNormal",
            "TelescopeBorder",
            "TelescopePreviewNormal",
            "TelescopePreviewBorder",
            "TelescopePromptNormal",
            "TelescopePromptBorder",
            "TelescopeResultsNormal",
            "TelescopeResultsBorder",
            -- 'VertSplit'
        },
        exclude = {}, -- table: groups you don't want to clear
    })
end

return M
