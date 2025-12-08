return {
    "azorng/goose.nvim",
    config = function()
        require("goose").setup({})
    end,
    cond = function()
        return vim.fn.executable("goose") == 1
    end,
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- {
        --     -- "MeanderingProgrammer/render-markdown.nvim",
        --     opts = {
        --         anti_conceal = { enabled = false },
        --     },
        -- }
    },
}
