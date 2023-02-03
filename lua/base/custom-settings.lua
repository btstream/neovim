local custom_file = vim.fn.expand(vim.fn.stdpath("config") .. "/custom.lua")
if vim.fn.filereadable(custom_file) == 1 then
    dofile(custom_file)
end
