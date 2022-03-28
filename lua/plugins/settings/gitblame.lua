local M = {}

vim.cmd([[
augroup setgitblame
    au!
    autocmd VimEnter * lua require('plugins.settings.gitblame').setup()
augroup end
]])

M.setup = function()
    if vim.g.colors_name == 'material' then
        local colors = require('material.colors')
        local bg = colors.bg_cur
        local fg = colors.comments
        vim.cmd('hi! gitblame guifg=' .. fg .. ' guibg=' .. bg)
    end
end

return M
