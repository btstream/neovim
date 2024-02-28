local icons = require("themes.icons")

local get_color = require("plugins.heirline.util").get_color
local separator = require("plugins.heirline.components.separator")

local function diagnostics_count(severity)
    local count
    if vim.diagnostic.count then
        count = vim.diagnostic.count(0)[vim.diagnostic.severity[severity]] or 0
    else -- TODO: remove when dropping support for neovim 0.9
        count = #vim.diagnostic.get(0, severity and { severity = vim.diagnostic.severity[severity] })
    end
    return count
end

local diagnostics_error = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Error .. " " .. self.error
    end,
    condition = function(self)
        return self.error > 0
    end,
    hl = function()
        return { fg = get_color("DarkRed") }
    end,
}

local diagnostics_warn = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Warn .. " " .. self.warn
    end,
    condition = function(self)
        return self.warn > 0
    end,
    hl = function()
        return { fg = get_color("purple") }
    end,
}

local diagnostics_info = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Info .. " " .. self.info
    end,
    condition = function(self)
        return self.info > 0
    end,
    hl = function()
        return { fg = get_color("blue") }
    end,
}

local diagnostics_hint = {
    provider = function(self)
        return " " .. icons.lsp_diagnostic_signs.Hint .. " " .. self.hint
    end,
    condition = function(self)
        return self.hint > 0
    end,
    hl = function()
        return { fg = get_color("cyan") }
    end,
}

return {
    init = function(self) end,
    separator({
        condition = function()
            return require("heirline.conditions").is_git_repo()
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
    update = { "DiagnosticChanged", "BufEnter" },
}
