return {
    "sudo-tee/opencode.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- {
        --     "MeanderingProgrammer/render-markdown.nvim",
        --     opts = {
        --         anti_conceal = { enabled = false },
        --         file_types = { 'markdown', 'opencode_output' },
        --     },
        --     ft = { 'markdown', 'Avante', 'copilot-chat', 'opencode_output' },
        -- },
        -- Optional, for file mentions and commands completion, pick only one
        'saghen/blink.cmp',
        -- 'hrsh7th/nvim-cmp',

        -- Optional, for file mentions picker, pick only one
        -- 'folke/snacks.nvim',
        -- 'nvim-telescope/telescope.nvim',
        -- 'ibhagwan/fzf-lua',
        -- 'nvim_mini/mini.nvim',
        { 'nvim-mini/mini.pick', version = false },
    },
    config = function()
        -- override create_float
        local CursorSpinner = require("opencode.quick_chat.spinner")
        function CursorSpinner:create_float()
            if not self.active or not vim.api.nvim_buf_is_valid(self.buf) then
                return
            end
            self.float_buf = vim.api.nvim_create_buf(false, true)
            local win_config = self:get_float_config()
            win_config.title = "  opencode "
            win_config.title_pos = "left"
            self.float_win = vim.api.nvim_open_win(self.float_buf, false, win_config)

            -- custom part
            vim.api.nvim_set_option_value(
                'winhl',
                'Normal:Normal,FloatBorder:OpencodeFloatBorder,FloatTitle:OpencodeFloatBorder',
                { win = self.float_win }
            )
            vim.api.nvim_set_option_value('wrap', false, { win = self.float_win })
        end

        require("mini.pick").setup({
        })
        require("opencode").setup({
            preferred_completion = "blink"
        })
    end,
}
