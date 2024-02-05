local M = {}

M.signs = require("themes.icons").lsp_diagnostic_signs

local function extend_open_floating_perview()
    local original = vim.lsp.util.open_floating_preview
    vim.lsp.util.open_floating_preview = function(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or { "", "", "", " ", "", "", "", " " }
        local buf, win = original(contents, syntax, opts, ...)

        if opts.winhighlight then
            vim.api.nvim_set_option_value("winhighlight", opts.winhighlight, { win = win })
        end

        return buf, win
    end
end

M.setup = function(opts)
    extend_open_floating_perview()

    if opts and opts.signs then
        M.signs = vim.tbl_extend("force", M.signs, opts.signs)
    end
end

return M
