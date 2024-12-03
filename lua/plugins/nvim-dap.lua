return {
    "mfussenegger/nvim-dap",
    event = "LspAttach",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap-python",
    },
    keys = {
        { "<F6>",      "<cmd>lua require'dap'.continue()<CR>" },
        { "<F10>",     "<cmd>lua require'dap'.step_over()<CR>" },
        { "<F11>",     "<cmd>lua require'dap'.step_into()<CR>" },
        { "<F12>",     "<cmd>lua require'dap'.step_out()<CR>" },
        { "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>" },
        { "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
        {

            "<leader>lp",
            "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
        },
        { "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>" },
        { "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>" },
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
    end,
}
