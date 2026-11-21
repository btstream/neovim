return {
    "keaising/im-select.nvim",
    cond = function()
        return vim.fn.executable("im-select") == 1     -- windows and mac
            or vim.fn.executable("im-select.exe") == 1 -- windows
            or vim.fn.executable("fcitx5-remote") == 1 -- linux fcitx5
            or vim.fn.executable("fcitx-remote") == 1  -- linux fcitx
            or vim.fn.executable("ibus") == 1          -- linux ibus
    end,
    config = function()
        require("im_select").setup({})
    end,
}
