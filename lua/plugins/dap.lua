return {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        require("plugins.settings.dap")
    end,
}
