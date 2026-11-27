local icons = require("themes.icons")

local separator = require("plugins.heirline.components.separator")

local function diagnostics_count(severity)
    return vim.diagnostic.count(0)[vim.diagnostic.severity[severity]] or 0
end

local diagnostics_error = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Error .. " " .. self.error
    end,
    condition = function(self)
        return self.error > 0
    end,
    hl = { fg = "DarkRed" },
}

local diagnostics_warn = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Warn .. " " .. self.warn
    end,
    condition = function(self)
        return self.warn > 0
    end,
    hl = { fg = "purple" },
}

local diagnostics_info = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Info .. " " .. self.info
    end,
    condition = function(self)
        return self.info > 0
    end,
    hl = { fg = "blue" },
}

local diagnostics_hint = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Hint .. " " .. self.hint
    end,
    condition = function(self)
        return self.hint > 0
    end,
    hl = { fg = "cyan" },
}

return {
    {
        provider = " ",
    },
    separator.make({
        -- gitsigns sets this only for buffers inside a git repository, so it
        -- replaces the old vim.g.in_git_repo global at zero cost
        condition = function()
            return vim.b[0].gitsigns_head ~= nil
        end,
    }),
    diagnostics_error,
    diagnostics_warn,
    diagnostics_info,
    diagnostics_hint,
    condition = function(self)
        self.error = diagnostics_count("ERROR")
        self.warn = diagnostics_count("WARN")
        self.info = diagnostics_count("INFO")
        self.hint = diagnostics_count("HINT")
        return self.error + self.warn + self.info + self.hint > 0
    end,
    -- GitSignsUpdate is here for the separator above: its visibility follows
    -- gitsigns' buffer state, which is set asynchronously after the buffer is
    -- shown. Heirline freezes this whole group while it has an `update`, so
    -- without this the separator would stay hidden until the next BufEnter.
    -- No `pattern` here on purpose: a pattern would also filter
    -- DiagnosticChanged/BufEnter by buffer name and silently disable them.
    update = { "DiagnosticChanged", "BufEnter", "User" },
}
