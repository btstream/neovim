return {
    'nvim-mini/mini.comment',
    version = false,
    event = { "User BufReadRealFile" },
    config = function()
        require('mini.comment').setup()
    end,
}
