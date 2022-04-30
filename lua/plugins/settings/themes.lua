vim.g.material_style = "Deep ocean"
-- local colors = require("plugins.settings.statusline.galaxyline.themes.colors.base16").get("material-darker")
require("material").setup({
    -- custom_colors = {
    --     accent = colors.blue, -- or whatever color you like
    --     blue = colors.blue,
    --     green = colors.green,
    -- },
    disable = {
        eob_line = true,
    },
})
require("nightfox").setup({})
vim.cmd("colorscheme material")
vim.cmd([[
augroup themes
    autocmd!
    autocmd VimEnter * lua require('plugins.settings.themes').set_transparent()
augroup end
]])

local M = {}
M.set_transparent = function()
    vim.cmd("highlight! link DashboardHeader String")
    local enable = false
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
