-- TODO:fix keymap
return {
    "rlue/vim-barbaric",
    cond = function()
        return vim.fn.has("win32") == 0
    end,
    event = "User BufReadRealFile",
    enabled = false,
    config = function()
        vim.g.barbaric_ime = "fcitx"
        if vim.fn.has("mac") == 1 then
            vim.g.barbaric_ime = "macos"
            vim.g.barbaric_default = 0
        end
    end,
}
