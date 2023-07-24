return {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap-python",
    },
    module = false,
    config = function()
        local dap = require("dap")

        -- local function setupdap()
        vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticError", numhl = "" })
        vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticHint", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticWarn", numhl = "" })

        -- config dapui
        dap.listeners.after.event_initialized["dapui_config"] = function()
            vim.g.dap_loaded = true
            require("dapui").open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            vim.g.dap_loaded = false
            require("dapui").close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            vim.g.dap_loaded = false
            require("dapui").close()
        end
        -- end

        -- setupdap()
        require("dapui").setup({
            icons = { expanded = "", collapsed = "", current_frame = "" },
        })
        require("dap-python").setup()

        require("keymaps").dap.set()
    end,
}
