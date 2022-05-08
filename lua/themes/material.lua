vim.g.material_style = "Deep ocean"
require("material").setup({
    disable = {
        eob_lines = true,
    },
})
vim.cmd("colorscheme material")
