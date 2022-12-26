local highlight = require("lualine.highlight")
local lsp_progress = require("lualine.components.lsp_progress")
local component = lsp_progress:extend()

lsp_progress.default = {
    colors = {
        percentage = highlight.get_lualine_hl("lualine_b_normal"),
        title = highlight.get_lualine_hl("lualine_b_normal"),
        message = highlight.get_lualine_hl("lualine_b_normal"),
        spinner = "#d19a66",
        lsp_client_name = highlight.get_lualine_hl("lualine_b_normal"),
        use = false,
    },
    separators = {
        component = " ",
        progress = " | ",
        message = { pre = "(", post = ")" },
        percentage = { pre = "", post = "%% " },
        title = { pre = "", post = ": " },
        lsp_client_name = { pre = "[", post = "]" },
        spinner = { pre = "", post = "" },
    },
    display_components = { "lsp_client_name", "spinner", { "title", "percentage", "message" } },
    timer = { progress_enddelay = 125, spinner = 125, lsp_client_name_enddelay = 1000 },
    spinner_symbols = { "", "", "", "", "", "", "", "" },
    message = { commenced = "In Progress", completed = "Completed" },
}

component.init = function(self, options)
    component.super.init(self, options)
    self.options.ignored_servers = vim.tbl_extend("force", { "null-ls" }, self.options.ignored_servers or {})
end

component.update_progress = function(self)
    local options = self.options
    local result = {}

    for _, client in pairs(self.clients) do
        if vim.tbl_contains(self.options.ignored_servers, client.name) then
            goto continue
        end

        for _, display_component in pairs(self.options.display_components) do
            if display_component == "lsp_client_name" then
                if options.colors.use then
                    table.insert(
                        result,
                        highlight.component_format_highlight(self.highlights.lsp_client_name)
                            .. options.separators.lsp_client_name.pre
                            .. client.name
                            .. options.separators.lsp_client_name.post
                    )
                else
                    table.insert(
                        result,
                        options.separators.lsp_client_name.pre .. client.name .. options.separators.lsp_client_name.post
                    )
                end
            end
            if display_component == "spinner" then
                local progress = client.progress
                for _, _ in pairs(progress) do
                    if options.colors.use then
                        table.insert(
                            result,
                            highlight.component_format_highlight(self.highlights.spinner)
                                .. options.separators.spinner.pre
                                .. self.spinner.symbol
                                .. options.separators.spinner.post
                        )
                    else
                        table.insert(
                            result,
                            options.separators.spinner.pre .. self.spinner.symbol .. options.separators.spinner.post
                        )
                    end
                    break
                end
                self:update_spinner()
            end
            if type(display_component) == "table" then
                self:update_progress_components(result, display_component, client.progress)
            end
        end

        ::continue::
    end
    if #result > 0 then
        self.progress_message = table.concat(result, options.separators.component)
    else
        local attached_clients = vim.lsp.buf_get_clients()
        local clients = {}
        for _, client in pairs(attached_clients) do
            if not vim.tbl_contains(self.options.ignored_servers, client.name) then
                table.insert(clients, client.name)
            end
        end
        local icon = ""
        local active_lsp = ""
        if #clients == 0 then
            icon = ""
            if vim.bo.filetype == "" then
                active_lsp = "plaintext"
            else
                active_lsp = vim.bo.filetype
            end
        else
            active_lsp = table.concat(clients, ",")
        end
        self.progress_message = string.format("%s %s", icon, active_lsp)
    end
end

component.setup_spinner = function(self)
    self.spinner = {}
    self.spinner.index = 0
    self.spinner.symbol_mod = #self.options.spinner_symbols
    self.spinner.symbol = self.options.spinner_symbols[1]
end

component.update_spinner = function(self)
    self.spinner.index = (self.spinner.index % self.spinner.symbol_mod) + 1
    self.spinner.symbol = self.options.spinner_symbols[self.spinner.index]
end

return component
