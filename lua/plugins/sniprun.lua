return {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cond = function() -- only load on macos and linux
        return vim.fn.has("win32") == 0
    end,
    event = "LspAttach",
    config = function()
        local map = vim.keymap.set
        require("sniprun").setup({ display = { "Classic" } })
        map("n", "<F5>", "<cmd>%SnipRun<CR>")
    end,
}
