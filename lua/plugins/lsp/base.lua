-- local lspconfig = require("lspconfig")
local inlay_hint = require("plugins.lsp.utils").inlay_hint
-- require("plugins.lsp.diagnostics.ui").setup()

----------------------------------------------------------------------
--                         common-settings                          --
----------------------------------------------------------------------
local lspconfig_utils = require("lspconfig.util")
local common_settings = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
    on_attach = require("plugins.lsp.utils").on_attach,
    single_file_support = true,
    offset_encoding = "utf-16",
})
vim.lsp.config("*", common_settings)

----------------------------------------------------------------------
--                     setup servers with mason                     --
----------------------------------------------------------------------
local disabled_server = { "pylyzer" }

require("plugins.lsp.mason")
for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
    if vim.tbl_contains(disabled_server, server_name) then
        goto continue
    end

    local x, _ = pcall(require, "plugins.lsp.without_lspconfig." .. server_name)
    if not x then
        local ss, config = pcall(require, "plugins.lsp.servers." .. server_name)
        config = ss and config or {}
        vim.lsp.config(server_name, config)
        vim.lsp.enable(server_name)
    end

    ::continue::
end

----------------------------------------------------------------------
--                     settings for inlayHints                      --
----------------------------------------------------------------------

---- enable inlayHints ----
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client:supports_method("textDocument/inlayHints") then
            inlay_hint(args.buf, true)
            vim.api.nvim_create_autocmd("ModeChanged", {
                buffer = args.buf,
                group = vim.api.nvim_create_augroup("LspInlayHintForBuf_" .. args.buf, { clear = true }),
                callback = function(ev)
                    if ev.match == "n:i" then
                        inlay_hint(args.buf, false)
                    elseif ev.match == "i:n" then
                        inlay_hint(args.buf, true)
                    end
                end,
            })
        end
    end,
})

-- a little trick for packer to load lspconfig lazily, which
-- is to call a BufRead autocmd to make current buffer attach
-- to lsp server
vim.schedule(function()
    vim.cmd("doautocmd BufRead")
end)
