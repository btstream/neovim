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

-- to inspect user's plugins specs
local spec = { { import = "plugins" } }
local user_spec_path = path.join(vim.fn.stdpath("config"), "lua", "users", "plugins")
if
    path.exists(user_spec_path)
    and #path.ls(user_spec_path, function(fname)
        return vim.fn.fnamemodify(fname, ":e") == "lua"
    end)
    > 0
then
    table.insert(spec, { import = "users.plugins" })
end

---@diagnostic disable-next-line: different-requires
require("lazy").setup({
    spec = spec,
    checker = {
        enabled = true,
        notify = false,
    },
    concurrency = 5,
})

require("utils.keymap").set({
    ---@diagnostic disable-next-line: different-requires
    { "n", "<C-k>U", require("utils.lazy").update_outdated, { desc = "Update Outdated plugins" } },
})
