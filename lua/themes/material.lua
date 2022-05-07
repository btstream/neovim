vim.g.material_style = "Deep ocean"
-- local colors = require("plugins.settings.statusline.galaxyline.themes.colors.base16").get("material-darker")
require("material").setup({
    -- custom_colors = {
    --     accent = colors.blue, -- or whatever color you like
    --     blue = colors.blue,
    --     green = colors.green,
    -- },
    -- contrast = {
    --     sidebars = true,
    --     floating_windows = true,
    --     non_current_windows = false,
    -- },
    -- contrast_filetypes = {
    --     "Lazygit",
    --     "Outline",
    -- },
    disable = {
        eob_lines = true,
    },
})
require("nightfox").setup({})
vim.cmd("colorscheme material")
