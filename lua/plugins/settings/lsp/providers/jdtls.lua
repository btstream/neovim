local jdtls = require("jdtls")
local find_root = require("jdtls.setup").find_root
-- local get_settings = require("nlspsettings").get_settings
local get_lua_settings = require("plugins.settings.lsp.nlspsettings_lualoader").get_settings

local lombok_path = require("mason.settings").current.install_root_dir .. "/packages/jdtls/lombok.jar"

if vim.fn.has("win32") == 1 then
    lombok_path = lombok_path:gsub("/", "\\\\")
end

local function start_jdtls()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, {
        workspace = {
            configuration = true,
        },
        textDocument = {
            completion = {
                completionItem = {
                    snippetSupport = true,
                },
            },
        },
    })

    -- extended capabilities
    local extendedClientCapabilities = jdtls.extendedClientCapabilities
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

    local root_dir = find_root({ "pom.xml", "mnvw", ".git", "gradlew" }) or vim.fn.getcwd()

    local config = {
        name = "jdtls",
        cmd = {
            "jdtls",
            "--jvm-arg=-javaagent:" .. lombok_path,
            "-data",
            vim.fn.expand("~/.cache/jdtls/workspace"),
            "-configuration",
            vim.fn.expand("~/.cache/jdtls/config"),
        },
        flags = { allow_incremental_sync = true },
        -- handlers = {
        --     ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
        -- },
        capabilities = capabilities,
        ["flags.server_side_fuzzy_completion"] = true,
        root_dir = root_dir,
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
        handlers = require("plugins.settings.lsp.handlers"),
        init_options = {
            extendedClientCapabilities = extendedClientCapabilities,
            bundles = {
                vim.fn.glob(
                    require("mason.settings").current.install_root_dir .. "/packages/java-debug-adapter/**/*debug*.jar",
                    1
                ),
            },
        },
        on_attach = function(client, bufnr)
            jdtls.setup_dap({ hotcodereplace = "auto" })
            jdtls.setup.add_commands()
            require("plugins.settings.lsp.utils").on_attach(client, bufnr)
        end,
    }

    -- config.settings = vim.tbl_deep_extend("force", config.settings, get_settings(root_dir, "jdtls"))
    config.settings = vim.tbl_deep_extend("force", config.settings, get_lua_settings(root_dir, "jdtls"))
    config.on_init = function(client, _)
        client.notify("workspace/didChangeConfiguration", { settings = config.settings })
    end
    jdtls.start_or_attach(config)
end

vim.api.nvim_create_augroup("StartJdtls", {
    clear = true,
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = start_jdtls,
    group = "StartJdtls",
})
