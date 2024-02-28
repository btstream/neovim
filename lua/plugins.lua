local path = require("utils.os.path")
local lazypath = path.join(vim.fn.stdpath("data"), "lazy", "lazy.nvim")
if not path.exists(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", { import = "users.plugins" }, {
    checker = {
        enabled = true,
        notify = false,
    },
    concurrency = 5,
})
