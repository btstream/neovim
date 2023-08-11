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
        local icons = require("themes.icons")

        -- local function setupdap()
        vim.fn.sign_define(
            "DapBreakpoint",
            { text = icons.dap_icons.BreakPoint, texthl = "DiagnosticError", numhl = "" }
        )
        vim.fn.sign_define(
            "DapBreakpointCondition",
            { text = icons.dap_icons.BreakPointCondition, texthl = "DiagnosticError", numhl = "" }
        )
        vim.fn.sign_define(
            "DapLogPoint",
            { text = icons.dap_icons.BreakLogPoint, texthl = "DiagnosticError", numhl = "" }
        )
        vim.fn.sign_define("DapStopped", { text = icons.dap_icons.BreakStopped, texthl = "DiagnosticHint", numhl = "" })
        vim.fn.sign_define(
            "DapBreakpointRejected",
            { text = icons.dap_icons.BreakPointRejected, texthl = "DiagnosticWarn", numhl = "" }
        )

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
        ---@diagnostic disable-next-line: missing-fields
        require("dapui").setup({
            icons = { expanded = "", collapsed = "", current_frame = "" },
        })
        require("dap-python").setup()

        require("keymaps").dap.set()
    end,
}
