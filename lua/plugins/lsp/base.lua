local lspconfig = require("lspconfig")
local lspconfig_utils = require("lspconfig.util")
local inlay_hint = require("plugins.lsp.utils").inlay_hint
local path = require("utils.os.path")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local user_lsp_settings_path = path.join(vim.fn.stdpath("config"), "lua", "users", "lsp-settings")
if not path.exists(user_lsp_settings_path) then
    path.mkdir(user_lsp_settings_path)
end

require("plugins.lsp.ui").setup()
-----------------------------------
-- setup nlspsettings to load
-- json and lua config for settings
-----------------------------------
---@diagnostic disable-next-line: missing-fields
require("nlspsettings").setup({
    config_home = user_lsp_settings_path,
    local_settings_dir = ".nvim",
    local_settings_root_markers = { ".git", ".nvim" },
    append_default_schemas = true,
    loader = "json",
})

-- lua config
lspconfig_utils.default_config = vim.tbl_deep_extend("force", lspconfig_utils.default_config, {
    on_attach = require("plugins.lsp.utils").on_attach,
    capabilities = capabilities,
    handlers = require("plugins.lsp.handlers"),
    -- add_hook_after, has a much more priority than nlspsettings.nvim
    on_new_config = lspconfig_utils.add_hook_after(
        lspconfig_utils.default_config.on_new_config,
        function(new_config, root_dir)
            local name = new_config.name
            -- require("plugins.lsp.nlspsettings_lualoader").get_settings(_, name)
            new_config.settings = vim.tbl_deep_extend(
                "keep",
                require("plugins.lsp.nlspsettings_lualoader").get_settings(root_dir, name),
                new_config.settings
            )
        end
    ),
})

-----------------------------------
-- setup lsp with mason
-----------------------------------
local disabled_server = { "pylyzer" }
local default_root_pattern = {
    -- custom pattern
    ".nvim",
    ".neovim",

    -- git
    ".git",

    -- for CMake managed projects
    "CMakeLists.txt",

    -- for python
    "setup.py",
    "tox.ini",
    "requirements.txt",
    "Pipfile",
    "pyproject.toml",
}

require("plugins.lsp.mason")
require("mason-lspconfig").setup_handlers({
    function(server_name)
        if vim.tbl_contains(disabled_server, server_name) then
            return
        end

        local orig_setup = lspconfig[server_name].setup
        lspconfig[server_name].setup = function(user_config)
            local new_config = vim.tbl_deep_extend("keep", user_config, {
                root_dir = function(fname)
                    local success, config = pcall(require, "lspconfig.server_configurations." .. server_name)
                    if success then
                        local default_root_dir = config.default_config.root_dir
                        if type(default_root_dir) == "function" then
                            default_root_dir = default_root_dir(fname)
                        end

                        -- if default root_dir get nil
                        -- find custom root_dirs
                        if not default_root_dir then
                            -- find git first
                            local git_ancestor = lspconfig_utils.find_git_ancestor(fname)
                            if git_ancestor then
                                return git_ancestor
                            end

                            -- find root based on custom root pattern
                            local pattern_root = lspconfig_utils.root_pattern(unpack(default_root_pattern))(fname)

                            -- use file's folder as root for last fallback
                            return pattern_root and pattern_root or vim.fn.fnamemodify(fname, ":p:h")
                        end
                        return default_root_dir
                    end
                end,
            })
            orig_setup(new_config)
        end

        if not pcall(require, "plugins.lsp.providers." .. server_name) then
            lspconfig[server_name].setup({})
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
