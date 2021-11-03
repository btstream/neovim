vim.cmd('colorscheme base16-material-darker')

require('transparent').setup({
    enable = true, -- boolean: enable transparent
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

vim.cmd([[
hi Visual ctermbg=DarkGrey guibg=DarkGrey
]])

