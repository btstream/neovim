local function replace_keys(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "windwp/nvim-autopairs",
        "rafamadriz/friendly-snippets",
        "onsails/lspkind-nvim",
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        -- local util = require 'lspconfig/util'

        local has_words_before = function()
            ---@diagnostic disable-next-line: deprecated
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        -- local feedkey = function(key, mode)
        --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
        -- end

        local symbol_map = require("themes.icons").lsp_symbols

        ---@diagnostic disable-next-line: redundant-parameter
        cmp.setup({
            enabled = function()
                if vim.bo.filetype == "grug-far" then
                    return false
                end

                -- disable completion in comments
                local context = require("cmp.config.context")
                -- keep command mode completion enabled when cursor is in a comment
                if vim.api.nvim_get_mode().mode == "c" then
                    return true
                else
                    return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
                end
            end,
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
                end,
            },
            window = {
                documentation = cmp.config.window.bordered({
                    border = "single",
                    winhighlight = "NormalFloat:CmpDocumentation,FloatBorder:CmpDocumentationBorder",
                }),
            },
            mapping = {
                -- stylua: ignore start
                ["<C-d>"]     = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
                ["<C-f>"]     = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
                ["<C-y>"]     = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
                ["<Esc>"]     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
                ["<C-c>"]     = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
                ["<CR>"]      = cmp.mapping.confirm({ select = true }),
                ["<Up>"]      = cmp.mapping(cmp.mapping.select_prev_item(), { "i" }),
                ["<Down>"]    = cmp.mapping(cmp.mapping.select_next_item(), { "i" }),
                ["<C-p>"]     = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
                ["<C-n>"]     = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
                ['<Tab>']     = cmp.mapping(function(fallback)
                    if vim.call('vsnip#available', 1) ~= 0 then
                        vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-next)'), '')
                    elseif cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>']   = cmp.mapping(function(fallback)
                    if vim.call('vsnip#available', -1) ~= 0 then
                        vim.fn.feedkeys(replace_keys('<Plug>(vsnip-jump-prev)'), '')
                    elseif cmp.visible() then
                        cmp.select_prev_item()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                -- ["<Tab>"]     = cmp.mapping(function(fallback)
                --     -- stylua: ignore end
                --     if cmp.visible() then
                --         cmp.select_next_item()
                --     elseif vim.fn["vsnip#available"](1) == 1 then
                --         feedkey("<Plug>(vsnip-expand-or-jump)", "")
                --     elseif has_words_before() then
                --         cmp.complete()
                --     else
                --         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
                --     end
                -- end, { "i", "s" }),
                --
                -- ["<S-Tab>"]   = cmp.mapping(function()
                --     if cmp.visible() then
                --         cmp.select_prev_item()
                --     elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                --         feedkey("<Plug>(vsnip-jump-prev)", "")
                --     end
                -- end, { "i", "s" }),
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "nvim_lsp_signature_help" },
                { name = "vsnip" },
                { name = "codeium" },
                { name = "path" },
                { name = "buffer" },
            }),
            completion = { completeopt = "menu,menuone,noinsert,preview" },
            -- cmp kind info
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = lspkind.cmp_format({
                    symbol_map = symbol_map,
                    mode = "symbol",
                    maxwidth = 50,
                    before = function(entry, vim_item)
                        if entry.source.name == "codeium" then
                            vim_item.kind_hl_group = "CmpItemKindCodeium"
                        end
                        return vim_item
                    end,
                }),
                -- end,
            },
        })

        -- Use buffer source for `/`.
        cmp.setup.cmdline("/", { sources = { { name = "buffer" } }, completion = { completeopt = "menu,noselect" } })

        -- Use cmdline & path source for ':'.
        cmp.setup.cmdline(":", {
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
            formatting = {
                fields = { "abbr", "kind" },
            },
            completion = { completeopt = "menu,noselect" },
        })

        -- TODO: ref https://github.com/hrsh7th/nvim-cmp/issues/877
        cmp.setup.filetype("java", {
            confirmation = {
                default_behavior = require("cmp.types").cmp.ConfirmBehavior.Replace,
            },
        })

        cmp.setup.filetype("snacks_picker_input", {
            enabled = false,
        })

        -- autopairs
        require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt", "vim" } })

        -- If you want insert `(` after select function or method item
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
    end,
}
