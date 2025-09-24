return {
    -- TODO: waiting updates for "ahmedkhalf/project.nvim"
    "DrKJeff16/project.nvim",
    event = { "User BufReadRealFilePost" },
    dependencies = "Shatur/neovim-session-manager",
    enabled = false,
    config = function()
        -- local project_nvim_project = require("project_nvim.project")
        -- local origi_set_pwd = project_nvim_project.set_pwd
        --
        -- -- override the project set_pwd function to follow the current buffer's path
        -- -- if not in a project dir
        -- ---@diagnostic disable-next-line: duplicate-set-field
        -- project_nvim_project.set_pwd = function(dir, method)
        --     if dir == nil then
        --         local current_buffer_dir = vim.fn.expand("%:p:h")
        --         vim.api.nvim_set_current_dir(current_buffer_dir)
        --     else
        --         origi_set_pwd(dir, method)
        --     end
        -- end

        require("project").setup({
            fzf_lua = {
                enabled = false
            }
        })
        local config = require("session_manager.config")
        require("session_manager").setup({
            autoload_mode = config.AutoloadMode.Disabled,
            autosave_last_session = true,      -- Automatically save last session on exit and on session switch.
            autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
            autosave_ignore_dirs = {},         -- A list of directories where the session will not be autosaved.
            autosave_ignore_filetypes = {      -- All buffers of these file types will be closed before the session is saved.
                "gitcommit",
                "gitrebase",
            },
            autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
            autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
            max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
        })

        -- a little trick to do an BufEnter event to update proejct's current dir
        -- on first load
        require("project.api").on_buf_enter()
    end,
}
