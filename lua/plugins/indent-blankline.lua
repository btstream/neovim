return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
        require("ibl").setup({
            scope = {
                show_start = false,
                show_end = false,
                highlight = "IndentBlanklineContextChar",
            },
            exclude = {
                filetypes = require("utils.filetype_tools").get_nonfiletypes(),
            },
        })
    end,
}
