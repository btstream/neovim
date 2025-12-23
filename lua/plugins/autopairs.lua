return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        local npairs = require('nvim-autopairs')
        -- local rule = require('nvim-autopairs.rule')
        npairs.setup({
            disable_filetype = require("utils.filetype").get_nonfiletypes(),
            -- enable_check_bracket_line = false,
            fast_wrap = {
                map = '<C-S-e>',
                chars = { '{', '[', '(', '"', "'" },
                pattern = [=[[%'%"%>%]%)%}%,]]=],
                end_key = '$',
                before_key = 'h',
                after_key = 'l',
                cursor_pos_before = true,
                keys = 'qwertyuiopzxcvbnmasdfghjkl',
                manual_position = true,
                highlight = 'Search',
                highlight_grey = 'Comment'
            }
        })
    end
}
