vim.g.barbaric_ime = "fcitx"
if vim.fn.has("mac") == 1 then
    print("THis is all shit")
    vim.g.barbaric_ime = "macos"
    vim.g.barbaric_default = 0
end
