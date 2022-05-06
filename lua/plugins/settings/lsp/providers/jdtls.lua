local jdtls = require("jdtls")
local function start_jdtls()
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
        cmd = require("nvim-lsp-installer.servers.jdtls"):get_default_options().cmd,
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
        on_attach = function(client, bufnr)
            jdtls.setup.add_commands()
            require("plugins.settings.lsp.utils").on_attach(client, bufnr)
        end,
    }

    jdtls.start_or_attach(config)
end

vim.api.nvim_create_augroup("StartJdtls", {
    clear = true,
})
vim.api.nvim_clear_autocmds("FileType", {
    pattern = "java",
    callback = start_jdtls,
    group = "StartJdtls",
})
