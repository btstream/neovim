local highlight = require("lualine.highlight")
local lsp_progress = require("lualine.components.lsp_progress")
local component = lsp_progress:extend()

component.init = function(self, options)
    options.spinner_symbols =
        vim.tbl_extend("force", lsp_progress.default.spinner_symbols_moon, options.spinner_symbols or {})
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

return component
