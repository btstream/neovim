local jdtls = require 'jdtls'
local M = {}
M.setup = function(opt)
    _JdtCmd = opt.cmd
    _OnAttach = opt.on_attach

    -- pickers
    local finders = require 'telescope.finders'
    local sorters = require 'telescope.sorters'
    local actions = require 'telescope.actions'
    local pickers = require 'telescope.pickers'
    local action_state = require 'telescope.actions.state'

    -- set pickers to use telescope
    require('jdtls.ui').pick_one_async = function(items, prompt, label_fn, cb)
        local opts = require('telescope.themes').get_cursor()
        pickers.new(opts, {
            prompt_title = prompt,
            finder = finders.new_table {
                results = items,
                entry_maker = function(entry)
                    return { value = entry, display = label_fn(entry), ordinal = label_fn(entry) }
                end
            },
            sorter = sorters.get_generic_fuzzy_sorter(),
            attach_mappings = function(prompt_bufnr)
                actions.select_default:replace(function()
                    local selection = action_state.get_selected_entry(prompt_bufnr)
                    actions.close(prompt_bufnr)
                    cb(selection.value)
                end)

                return true
            end
        }):find()
    end

    -- register startup hook
    vim.cmd([[
        augroup user-jdtls
            autocmd!
            autocmd FileType java lua require('plugins.settings.lsp.jdtls').start()
            autocmd BufWritePre *.java lua vim.lsp.buf.formatting_sync(nil, 1000)
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
    local extendedClientCapabilities = jdtls.extendedClientCapabilities;
    extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

    local config = {
        name = "jdtls",
        cmd = _JdtCmd,
        flags = { allow_incremental_sync = true },
        -- handlers = {
        --     ["textDocument/publishDiagnostics"] = lsp_diag.publishDiagnostics,
        -- },
        capabilities = capabilities,
        ['flags.server_side_fuzzy_completion'] = true,
        -- settings
        settings = {
            java = {
                signatureHelp = { enabled = true },
                contentProvider = { preferred = 'fernflower' },
                completion = {
                    favoriteStaticMembers = {
                        "org.hamcrest.MatcherAssert.assertThat",
                        "org.hamcrest.Matchers.*",
                        "org.hamcrest.CoreMatchers.*",
                        "org.junit.jupiter.api.Assertions.*",
                        "java.util.Objects.requireNonNull",
                        "java.util.Objects.requireNonNullElse",
                        "org.mockito.Mockito.*"
                    }
                },
                sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
                codeGeneration = {
                    toString = { template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}" }
                }
            }
        },
        init_options = { extendedClientCapabilities = extendedClientCapabilities },
        on_init = function(client)
            if client.config.settings then
                client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
            end
        end,
        on_attach = function(client, bufnr)
            require('lsp-status').register_progress()
            jdtls.setup.add_commands()
            _OnAttach(client, bufnr)
        end
    }

    jdtls.start_or_attach(config)
end

return M

