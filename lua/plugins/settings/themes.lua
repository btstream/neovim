vim.cmd('colorscheme base16-material-darker')

function set_transparent()
    local enable = true
    if vim.g.GuiLoaded then
        print("GuiLoaded")
        enable = false
    end
    require('transparent').setup({
        enable = enable, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be clear
            -- In particular, when you set it to 'all', that means all avaliable groups

            -- example of akinsho/nvim-bufferline.lua
            -- "BufferLineTabClose",
            -- "BufferlineBufferSelected",
            -- "BufferLineFill",
            -- "BufferLineBackground",
            -- "BufferLineSeparator",
            -- "BufferLineIndicatorSelected",
            'GitGutterAdd',
            'GitGutterDelete',
            'GitGutterChange',
            'NormalNC',
            'Terminal'
        },
        exclude = {
        }, -- table: groups you don't want to clear
    })
end

vim.cmd([[
hi! link Visual CursorLine
augroup set_transparent
    autocmd!
    autocmd VimEnter * lua set_transparent()
augroup end
]])

