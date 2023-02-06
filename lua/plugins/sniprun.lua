return {
    "michaelb/sniprun",
    build = "bash ./install.sh",
    cond = function() -- only load on macos and linux
        return vim.fn.has("win32") == 0
    end,
    event = "LspAttach",
    config = function()
        require("sniprun").setup({ display = { "Classic" } })
        require("keymaps").sniprun.set()
    end,
}
