local map = vim.keymap.set

require("rest-nvim").setup({
    -- Open request results in a horizontal split
    result_split_horizontal = false,
    -- Skip SSL verification, useful for unknown certificates
    skip_ssl_verification = false,
    -- Highlight request on run
    highlight = { enabled = true, timeout = 150 },
    result = {
        -- toggle showing URL, HTTP info, headers at top the of result window
        show_url = true,
        show_http_info = true,
        show_headers = true,
    },
    -- Jump to request line on run
    jump_to_request = false,
    env_file = ".env",
    custom_dynamic_variables = {},
    yank_dry_run = true,
})

map("n", "<leader>rr", ":lua require('rest-nvim').run()<CR>")
