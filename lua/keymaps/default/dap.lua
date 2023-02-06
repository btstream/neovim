return {
    { "n", "<F6>", "<cmd>lua require'dap'.continue()<CR>" },
    { "n", "<F10>", "<cmd>lua require'dap'.step_over()<CR>" },
    { "n", "<F11>", "<cmd>lua require'dap'.step_into()<CR>" },
    { "n", "<F12>", "<cmd>lua require'dap'.step_out()<CR>" },
    { "n", "<leader>b", "<cmd>lua require'dap'.toggle_breakpoint()<CR>" },
    { "n", "<leader>B", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
    { "n", "<leader>lp", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
    { "n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>" },
    { "n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>" },
}
