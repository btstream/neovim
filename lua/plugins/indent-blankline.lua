local exclude_filetypes = require("utils.filetype").get_nonfiletypes()
table.insert(exclude_filetypes, "fortran")
return {
    "lukas-reineke/indent-blankline.nvim",
    event = "User BufReadRealFile",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
        indent = { char = "▏" },
        scope = {
            show_start = false,
            show_end = false,
            highlight = "IndentBlanklineContextChar",
        },
        exclude = exclude_filetypes,
    },
    config = function(_, opts)
        require("ibl").setup(opts)
    end,
}
