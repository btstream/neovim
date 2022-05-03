-- for neovide
if vim.g.neovide then
    if vim.fn.has("wsl") or vim.fn.has("win32") then
        vim.cmd("set guifont=JetbrainsMono\\ NF:h9")
    end
end
