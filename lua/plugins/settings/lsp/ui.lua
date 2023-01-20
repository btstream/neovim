local M = {}

M.signs = {
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
}

local function extend_open_floating_perview()
    local original = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or { "", "", "", " ", "", "", "", " " }
        local bufnr, winnr = original(contents, syntax, opts, ...)

        if opts.winhighlight then
            vim.api.nvim_win_set_option(winnr, "winhighlight", opts.winhighlight)
        end

        return bufnr, winnr
    end
end

M.setup = function(opts)
    extend_open_floating_perview()

    if opts and opts.signs then
        M.signs = vim.tbl_extend("force", M.signs, opts.signs)
    end
end

return M
