local function terminal_info()
    return "[" .. vim.b.toggle_number .. "]:" .. vim.b.term_title
end

return terminal_info
