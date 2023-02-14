return {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    enabled = vim.fn.has("win32") == 0,
    event = "LspAttach",
    config = function()
        require("sniprun").setup({ display = { "Classic" } })
        require("keymaps").sniprun.set()
    end,
}
