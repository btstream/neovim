return {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = {
        'rafamadriz/friendly-snippets',
        -- "onsails/lspkind-nvim",
        "xzbdmw/colorful-menu.nvim",
        'ribru17/blink-cmp-spell'
    },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    config = function()
        require("colorful-menu").setup()
        -- require("lspkind").init({
        --     symbol_map = require("themes.icons").lsp_symbols
        -- })
        require("blink.cmp").setup({
            keymap = { preset = 'enter' },

            appearance = {
                nerd_font_variant = 'mono',
                kind_icons = require("themes.icons").lsp_symbols
            },

            completion = {
                documentation = { auto_show = true },
                menu = {
                    padding = { 0, 1 },
                    draw = {
                        columns = { { "kind_icon", gap = 1 }, { "label", gap = 1 } },
                        components = {
                            label = {
                                width = { min = 30, max = 60 },
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                    },
                },
            },

            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer', "spell" },
                providers = {
                    -- ...
                    spell = {
                        name = 'Spell',
                        module = 'blink-cmp-spell',
                        opts = {
                            -- EXAMPLE: Only enable source in `@spell` captures, and disable it
                            -- in `@nospell` captures.
                            enable_in_context = function()
                                local curpos = vim.api.nvim_win_get_cursor(0)
                                local captures = vim.treesitter.get_captures_at_pos(
                                    0,
                                    curpos[1] - 1,
                                    curpos[2] - 1
                                )
                                local in_spell_capture = false
                                for _, cap in ipairs(captures) do
                                    if cap.capture == 'spell' then
                                        in_spell_capture = true
                                    elseif cap.capture == 'nospell' then
                                        return false
                                    end
                                end
                                return in_spell_capture
                            end,
                        },
                    },
                },
            },

            signature = { enabled = true },

            fuzzy = {
                implementation = "prefer_rust_with_warning",
                sorts = {
                    function(a, b)
                        local sort = require('blink.cmp.fuzzy.sort')
                        if a.source_id == 'spell' and b.source_id == 'spell' then
                            return sort.label(a, b)
                        end
                    end,
                    -- This is the normal default order, which we fall back to
                    'score',
                    'kind',
                    'label',
                },
            }
        })
    end,
    opts_extend = { "sources.default" }
}
