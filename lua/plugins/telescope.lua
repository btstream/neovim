return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = vim.fn.executable("mingw32-make") == 1 and "mingw32-make" or "make",
            lazy = true,
        },
        "ahmedkhalf/project.nvim",
    },
    cmd = "Telescope",
    keys = {
        { mode = { "n" }, "<Leader>fh", "<cmd>Telescope oldfiles<CR>", desc = "Open file history" },
        { mode = { "n" }, "<Leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files in cwd" },
        { mode = { "n" }, "<Leader>tc", "<cmd>Telescope colorscheme<CR>", desc = "Change colorscheme" },
        { mode = { "n" }, "<Leader>fw", "<cmd>Telescope live_grep<CR>", desc = "Find word in workspace" },
        { mode = { "n" }, "<Leader>cn", "<cmd>enew<CR>", desc = "Create new file" },
        { mode = { "n" }, "<Leader>fp", "<cmd>Telescope projects<cr>", desc = "Project history" },
        { mode = { "n" }, "<Leader>ss", "e " .. vim.fn.stdpath("config") .. "/" .. "init.lua", desc = "Open Settings" },
        { mode = { "n", "i" }, "<C-k>p", "<cmd>Telescope find_files<cr>", desc = "find file" },
        { mode = { "n", "i" }, "<C-k>s", "<cmd>Telescope lsp_document_symbols<cr>", desc = "show document symboles" },
        {
            mode = { "n", "i" },
            "<C-k><S-s>",
            "<cmd>Telescope lsp_workspace_symbols<cr>",
            desc = "show workspace symboles",
        },
        { mode = { "n", "i" }, "<C-k>f", "<cmd>Telescope live_grep<cr>", desc = "find word in workspace" },
        { mode = { "n", "i" }, '<C-k>"', "<cmd>Telescope registers<cr>", desc = "look up registers" },
        { mode = { "n" }, "z=", "<cmd>Telescope spell_suggest<cr>", desc = "spell suggest" },
        { mode = { "n", "i" }, "<C-k><C-o>", "<cmd>Telescope file_browser<cr>", desc = "open file browser" },
        { mode = { "n", "i" }, "<C-b>", "<cmd>Telescope buffers<cr>", desc = "open buffers" },
        { mode = { "n", "i" }, "<C-k>r", "<cmd>Telescope resume<cr>", desc = "resume last Telescope session" },
    },
    config = function()
        local actions = require("telescope.actions")
        local action_set = require("telescope.actions.set")
        local fix_win_hijack = {
            attach_mappings = function()
                action_set.select:replace(function(prompt_bufnr, type)
                    local action_state = require("telescope.actions.state")

                    local picker = action_state.get_current_picker(prompt_bufnr)
                    local old_get_selection_window = picker.get_selection_window
                    picker.get_selection_window = function(picker, entry)
                        local w = old_get_selection_window(picker, entry)
                        if not require("utils.filetype").is_nonefiletype(vim.api.nvim_win_get_buf(w)) then
                            picker.get_selection_window = nil
                            return w
                        end

                        local picked_window_id = require("utils.window").get_first_normal_window()
                            or vim.api.nvim_get_current_win()
                        -- Unbind after using so next instance of the picker acts normally
                        picker.get_selection_window = nil
                        return picked_window_id
                    end
                    action_set.edit(prompt_bufnr, action_state.select_key_to_edit_key(type))
                    pcall(function()
                        if package.loaded.glance then
                            require("glance").actions.close()
                        end
                    end)
                end)
                return true
            end,
        }

        require("telescope").setup({
            defaults = {
                sorting_strategy = "ascending",
                layout_config = { prompt_position = "top" },
                mappings = {
                    i = { ["<esc>"] = actions.close },
                    n = { ["<esc>"] = actions.close },
                },
                prompt_prefix = "     ",
                selection_caret = "  ",
                entry_prefix = "  ",
            },
            pickers = {
                -- find_files = {
                --     theme = "dropdown"
                -- },
                buffers = fix_win_hijack,
                find_files = fix_win_hijack,
                git_files = fix_win_hijack,
                grep_string = fix_win_hijack,
                live_grep = fix_win_hijack,
                oldfiles = fix_win_hijack,
                lsp_code_actions = { theme = "cursor" },
                spell_suggest = { theme = "cursor" },
                colorscheme = {
                    enable_preview = true,
                },
            },
            extensions = {
                -- ["ui-select"] = { require("telescope.themes").get_dropdown() },
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            },
        })

        -- require("telescope").load_extension("ui-select")
        require("telescope").load_extension("fzf")
        require("telescope").load_extension("projects")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("notify")
    end,
}
