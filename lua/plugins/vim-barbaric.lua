return {
    "rlue/vim-barbaric",
    cond = function()
        return vim.fn.has("win32") == 0
    end,
    event = "User BufReadRealFile",
    config = function()
        require("plugins.settings.barbaric")
    end,
}
