local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local lsp_settings_path = vim.fn.stdpath("config") .. "/lsp-settings"

require("plugins.settings.lsp.ui").setup()
-----------------------------------
-- setup nlspsettings to load
-- json and lua config for settings
-----------------------------------
---@diagnostic disable-next-line: missing-fields
require("nlspsettings").setup({
    config_home = lsp_settings_path,
    local_settings_dir = ".nvim",
    local_settings_root_markers = { ".git", ".nvim" },
    append_default_schemas = true,
    loader = "json",
})

-- lua config
lspconfig_utils.default_config = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
    on_attach = require("plugins.settings.lsp.utils").on_attach,
    capabilities = capabilities,
    handlers = require("plugins.settings.lsp.handlers"),
    -- add_hook_after, has a much more priority than nlspsettings.nvim
    on_new_config = lspconfig_utils.add_hook_after(
        lspconfig_utils.default_config.on_new_config,
        function(new_config, root_dir)
            local name = new_config.name
            new_config.settings = vim.tbl_deep_extend(
                "keep",
                require("plugins.settings.lsp.nlspsettings_lualoader").get_settings(root_dir, name),
                new_config.settings
            )
        end
    ),
})

-----------------------------------
-- setup lsp with mason
-----------------------------------
require("plugins.settings.lsp.mason")
local disabled_server = { "pylyzer" }
require("mason-lspconfig").setup_handlers({
    function(server_name)
        -- if server_name == "pyright" then
        --     return
        -- end
        if vim.tbl_contains(disabled_server, server_name) then
            return
        end
        if not pcall(require, "plugins.settings.lsp.providers." .. server_name) then
            lspconfig[server_name].setup({})
        end
    end,
})

----------------------------------------------------------------------
--                     settings for inlayHints                      --
----------------------------------------------------------------------

---- enable inlayHints ----
-- vim.api.nvim_create_autocmd("LspAttach", {
--     group = vim.api.nvim_create_augroup("UserLspConfig", {}),
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client.server_capabilities.inlayHintProvider or client.supports_method("textDocument/inlayHints") then
--             vim.schedule(function()
--                 vim.lsp.inlay_hint.enable(args.buf, true)
--             end)
--         end
--         -- whatever other lsp config you want
--     end,
-- })

---- toggle inlayHints for different modes ----
-- vim.api.nvim_create_autocmd("ModeChanged", {
--     callback = function(args)
--         local buf = args.buf
--         local match = args.match
--         local clients = vim.lsp.get_clients({ buf = buf })
--         for _, client in ipairs(clients) do
--             if client.supports_method("textDocument/inlayHints") then
--                 if match == "n:i" then
--                     vim.lsp.inlay_hint.enable(buf, false)
--                 elseif match == "i:n" then
--                     vim.lsp.inlay_hint.enable(buf, true)
--                 end
--             end
--         end
--     end,
-- })

-- a little trick for packer to load lspconfig lazily, which
-- is to call a BufRead autocmd to make current buffer attach
-- to lsp server
vim.schedule(function()
    vim.cmd("doautocmd BufRead")
end)
