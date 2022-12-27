vim.g.barbaric_ime = "fcitx"
if vim.fn.has("mac") == 1 then
    vim.g.barbaric_ime = "macos"
    vim.g.barbaric_default = 0
end
