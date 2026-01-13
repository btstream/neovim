-- supported_acp_servers and will be checked in this order to set providers
local supported_acp_servers = {
    opencode = "opencode-acp",
    qwen = "gemini-acp",
    gemini = "gemini-acp",
    ["codex-acp"] = "codex-acp",
    ["claude-code-acp"] = "claude-acp",
    ["cursor-agent-acp"] = "cursor-acp"
}

local provider_check_order = {
    "opencode",
    "qwen",
    "gemini",
    "codex-acp",
    "claude-code-acp",
    "cusor-agent-acp"
}

local existed_acps = {}
for cmd, _ in pairs(supported_acp_servers) do
    if vim.fn.executable(cmd) then
        existed_acps[#existed_acps + 1] = cmd
    end
end

return {
    "carlos-algms/agentic.nvim",
    enabled = function()
        return #existed_acps
    end,
    keys = {
        {
            "<C-\\>",
            function() require("agentic").toggle() end,
            mode = { "n", "v", "i" },
            desc = "Toggle Agentic Chat"
        },
        {
            "<C-'>",
            function() require("agentic").add_selection_or_file_to_context() end,
            mode = { "n", "v" },
            desc = "Add file or selection to Agentic to Context"
        },
        {
            "<C-,>",
            function() require("agentic").new_session() end,
            mode = { "n", "v", "i" },
            desc = "New Agentic Session"
        },
    },

    opts = function()
        local config = {
            -- Available by default: "claude-acp" | "gemini-acp" | "codex-acp" | "opencode-acp" | "cursor-acp"
            -- provider = "opencode-acp", -- setting the name here is all you need to get started
            windows = {
                width = "32%",
                chat = { win_opts = {} },
                input = { height = 10, win_opts = {} },
                code = { win_opts = {} },
                files = { win_opts = {} },
                todos = { display = true, max_height = 10, win_opts = {} },
            },
        }
        local acp_providers = {}

        -- if qwen exist in systems, add it to providers
        if vim.tbl_contains(existed_acps, "qwen") and not vim.tbl_contains(existed_acps, "gemini-acp") then
            acp_providers["gemini-acp"] = {
                name = "Qwen ACP",
                command = "qwen",
                args = { "--experimental-acp" },
                env = {
                    NODE_NO_WARNINGS = "1",
                    IS_AI_TERMINAL = "1",
                },
            }
        end

        if not vim.tbl_isempty(acp_providers) then
            config.acp_providers = acp_providers
        end

        -- setting default provider
        for _, cmd in pairs(provider_check_order) do
            if vim.tbl_contains(existed_acps, cmd) then
                config.provider = supported_acp_servers[cmd]
                break
            end
        end

        return config
    end

}
