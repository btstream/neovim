local M = {}
local lsp_process_config = {
    show_filename = true,
    component_separator = ' ',
    spinner_frames = {'⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷'},
}
local messages = require('lsp-status').messages

M.get_lsp_progress = function()
    local buf_messages = messages()
    local msgs = {}

    for _, msg in ipairs(buf_messages) do
        -- local name = msg.name
        -- local client_name = '[' .. name .. ']'
        local contents
        if msg.progress then
            contents = msg.title
            if msg.message then contents = contents .. ' ' .. msg.message end

            -- this percentage format string escapes a percent sign once to show a percentage and one more
            -- time to prevent errors in vim statusline's because of it's treatment of % chars
            if msg.percentage then contents = contents .. string.format(" (%.1f%%)", msg.percentage) end

            if msg.spinner then
                contents = lsp_process_config.spinner_frames[(msg.spinner % #lsp_process_config.spinner_frames) + 0] .. ' ' ..
                    contents
            end
        elseif msg.status then
            contents = msg.content
            if lsp_process_config.show_filename and msg.uri then
                local filename = vim.uri_to_fname(msg.uri)
                filename = vim.fn.fnamemodify(filename, ':~:.')
                local space = math.min(59, math.floor(0.6 * vim.fn.winwidth(0)))
                if #filename > space then filename = vim.fn.pathshorten(filename) end

                contents = '(' .. filename .. ') ' .. contents
            end
        else
            contents = msg.content
        end

        table.insert(msgs, ' ' .. contents)
    end
    return table.concat(msgs, lsp_process_config.component_separator)
end


M.attach_keys = function(client, bufnr)
    -- set keyboar for buffer
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<C-k><C-f>', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    if client.name == 'jdtls' then
        buf_set_keymap('n', '<C-k>.', '<cmd>lua require("jdtls").code_action()<cr>', opts)
    else
        buf_set_keymap('n', '<C-k>.', '<cmd>Telescope lsp_code_actions<cr>', opts)
        buf_set_keymap('i', '<C-k>.', '<Esc><cmd>Telescope lsp_code_actions<cr>', opts)
    end

end

return M
