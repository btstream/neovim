local M = {}

vim.g.gitblame_ignored_filetypes = { "NvimTree", "Outline", "packer" }

-- set gitblame's color scheme after vim fully loaded, in order to
-- get correct color scheme.
-- vim.cmd([[
-- augroup setgitblame
--     au!
--     autocmd VimEnter * lua require('plugins.settings.gitblame').setup()
-- augroup end
-- ]])

vim.api.nvim_create_augroup("setgitblame", {
    clear = true,
})
vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    callback = function()
        if vim.g.colors_name == "material" then
            local colors = require("material.colors")
            local bg = colors.bg_cur
            local fg = colors.comments
            vim.cmd("hi! gitblame guifg=" .. fg .. " guibg=" .. bg)
        end
    end,
})

return M
