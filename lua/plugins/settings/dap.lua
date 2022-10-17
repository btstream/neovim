local dap = require("dap")

-- vim.cmd([
vim.cmd([[
    nnoremap <silent> <F6> :lua require'dap'.continue()<CR>
    nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
    nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
    nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>
    nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
    nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
]])

local function setupdap()
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticHint", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticWarn", numhl = "" })

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
end

require("dapui").setup()
require("dap-python").setup()
