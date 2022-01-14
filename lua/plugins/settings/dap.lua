local dap_install = require("dap-install")
local di_api = require("dap-install.api.debuggers")
local dap = require('dap')
local dapui = require('dapui')
dap_install.setup({ installation_path = vim.fn.stdpath("data") .. "/dapinstall/" })

-- auto install debugger-adaptors
vim.cmd([[
augroup DapAutoInstall
    autocmd!
    autocmd VimEnter * lua require('plugins.settings.dap').setup()
augroup end
]])

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

local M = {}
M.setup = function()
    -- auto install
    require('plugins.settings.dap.install')
    for _, d in pairs(di_api.get_installed_debuggers()) do
        if d == 'codelldb' then
            require('plugins.settings.dap.rust')
        else
            dap_install.config(d)
        end
    end

    vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'DiagnosticError', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '➡', texthl = 'DiagnosticHint', numhl = '' })

    -- config dapui
    dapui.setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        vim.g.dap_loaded = true
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        vim.g.dap_loaded = false
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        vim.g.dap_loaded = false
        dapui.close()
    end
end
return M
