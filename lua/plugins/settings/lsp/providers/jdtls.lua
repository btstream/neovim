local jdtls = require("jdtls")
local M = {}
M.setup = function(opt)
    _JdtCmd = opt.cmd
    _OnAttach = opt.on_attach
    _OnInit = opt.on_init
    -- register startup hook
    vim.cmd([[
        augroup user-jdtls
            autocmd!
            autocmd FileType java lua require('plugins.settings.lsp.providers.jdtls').start()
        augroup end
    ]])
end

M.start = function()
    -- local root_markers = {'gradlew', '.git'}
    -- local root_dir = require('jdtls.setup').find_root(root_markers)
    -- local home = os.getenv('HOME')
    -- local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

    -- .make basic config
    -- basic capabilities
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.workspace.configuration = true
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- extended capabilities
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local config = {
        name = "jdtls",
        cmd = _JdtCmd,
        flags = { allow_incremental_sync = true },
        -- handlers = {
        --     ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
        -- },
        capabilities = capabilities,
        ["flags.server_side_fuzzy_completion"] = true,
        root_dir = require("jdtls.setup").find_root({ "pom.xml", "mnvw", ".git", "gradlew" }),
        -- settings
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*",
                    },
                },
                saveActions = { organizeImports = true },
                sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
                codeGeneration = {
                    toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" },
                },
            },
        },
        init_options = { extendedClientCapabilities = extendedClientCapabilities },
        on_init = _OnInit,
        on_attach = function(client, bufnr)
            jdtls.setup.add_commands()
            _OnAttach(client, bufnr)
        end,
    }

    jdtls.start_or_attach(config)
end

return M
