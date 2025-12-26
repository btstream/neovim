local lsp_diagnostic_signs = require("themes.icons").lsp_diagnostic_signs

local ns = vim.api.nvim_create_namespace("LspDiagnosticsFloatIcont")

local float_opts = {
    border = "rounded",
    focusable = false,
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    header = "",
    title = " 󰩂 Diagnostics ",
    source = "always",
    max_width = 180,
    winhighlight =
    "NormalFloat:LspWinDiagnosticsNormal,FloatBorder:LspWinDiagnosticsBorder,FloatTitle:LspWinDiagnosticsTitle",
}

local icons = {
    lsp_diagnostic_signs.Error,
    lsp_diagnostic_signs.Warn,
    lsp_diagnostic_signs.Info,
    lsp_diagnostic_signs.Hint
}

local highlights = {
    "Error",
    "Warning",
    "Information",
    "Hint",
}

-- from vim.runtime
local function get_logical_pos(diagnostic)
    local ns = vim.diagnostic.get_namespace(diagnostic.namespace)
    local extmark = vim.api.nvim_buf_get_extmark_by_id(
        diagnostic.bufnr,
        ns.user_data.location_ns,
        diagnostic._extmark_id,
        { details = true }
    )

    return extmark[1], extmark[2], extmark[3].end_row, extmark[3].end_col, not extmark[3].invalid
end

local function open_float(_)
    local bufnr = vim._resolve_bufnr()
    local diagnostics = vim.diagnostic.get(bufnr)

    if #diagnostics == 0 then
        return
    end

    ----------------------------------------------------------------------
    --            get diagnostics on current cursor position            --
    ----------------------------------------------------------------------
    -- get current cursor's position
    local pos = vim.api.nvim_win_get_cursor(0)
    local lnum = pos[1] - 1
    local col = pos[2]

    -- filter diagnostics on current cursor position
    local line_length = #vim.api.nvim_buf_get_lines(bufnr, lnum, lnum + 1, true)[1]
    diagnostics = vim.tbl_filter(function(d)
        local d_lnum, d_col, d_end_lnum, d_end_col = get_logical_pos(d)

        return lnum >= d_lnum
            and lnum <= d_end_lnum
            and (lnum ~= d_lnum or col >= math.min(d_col, line_length - 1))
            and ((d_lnum == d_end_lnum and d_col == d_end_col) or lnum ~= d_end_lnum or col < d_end_col)
    end, diagnostics)

    -- if no diagnostics return
    if vim.tbl_isempty(diagnostics) then
        return
    end

    -- sort diagnostics
    table.sort(diagnostics, function(a, b)
        return a.severity > b.severity
    end)

    ----------------------------------------------------------------------
    --                   format diagnostics messages                    --
    ----------------------------------------------------------------------
    local messages = {}
    local hls = {}
    for _, d in pairs(diagnostics) do
        local icon = icons[d.severity]
        local hl = highlights[d.severity] or "Normal"
        for i, m in ipairs(vim.split(d.message, "\n")) do
            if i ~= 1 then
                icon = " "
            end
            messages[#messages + 1] = " " .. icon .. " " .. m
            hls[#hls + 1] = "LspDiagnosticsDefault" .. hl
        end
    end

    local msg_buf, dia_win = vim.lsp.util.open_floating_preview(messages, "markdown", float_opts)

    -- set highlights for signs
    for i, hl in ipairs(hls) do
        vim.api.nvim_buf_set_extmark(msg_buf, ns, i - 1, 0, { end_col = 3, hl_group = hl })
    end

    if dia_win then
        vim.api.nvim_set_option_value("winhighlight", float_opts.winhighlight, { win = dia_win })
    end
end

vim.diagnostic.open_float = open_float
