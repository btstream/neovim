local lspconfig = require("lspconfig")
local inlay_hint = require("plugins.lsp.utils").inlay_hint

require("plugins.lsp.ui").setup()
require("plugins.lsp.servers").common_settings()

-----------------------------------
-- setup lsp with mason
-----------------------------------
local disabled_server = { "pylyzer" }

require("plugins.lsp.mason")
require("mason-lspconfig").setup_handlers({
    function(server_name)
        if vim.tbl_contains(disabled_server, server_name) then
            return
        end

        -- some of servers need to config manually, such as jdtls
        local x, m = pcall(require, "plugins.lsp.without_lspconfig." .. server_name)
        if not x then
            local ss, config = pcall(require, "plugins.lsp.servers." .. server_name)
            config = ss and config or {}
            lspconfig[server_name].setup(config)
        end
    end,
})

----------------------------------------------------------------------
--                     settings for inlayHints                      --
----------------------------------------------------------------------

---- enable inlayHints ----
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.supports_method("textDocument/inlayHints") then
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
