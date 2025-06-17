local terminal = require("nvim_aider.terminal")
local path = require("utils.os.path")
local orig_toggle = terminal.toggle

function terminal.toggle(opts)
    local args = {
        "--no-auto-commits",
        "--pretty",
        "--stream",
        "--watch-files",
        "--openai-api-base https://llm.chutes.ai/v1",
        "--editor-model openai/deepseek-ai/DeepSeek-V3-0324",
        "--model openai/deepseek-ai/DeepSeek-R1-0528",
        "--model-metadata-file " .. path.join(vim.fn.stdpath("config"), "extra", "aider-model-metadata.json"),
        "--model-settings-file " .. path.join(vim.fn.stdpath("config"), "extra", "aider-model-settings.yml"),
        "--architect",
        -- "--no-show-model-warnings",
        "--code-theme one-dark"
    }

    -- save chat history and cache in a seprated folder
    local project_root = path.find_root()
    if not path.exists(path.join(project_root, ".git")) then
        table.insert(args, "--no-git")
    end

    -- cache dir
    local aider_cach_path = path.join(vim.fn.stdpath("cache"), "aider")
    if not path.exists(aider_cach_path) then
        path.mkdir(aider_cach_path)
    end

    local seps = vim.split(vim.fs.normalize(project_root), "/")
    for i, j in ipairs(seps) do
        if i == #seps then
            break
        end
        local s = string.sub(j, 1, 1)
        seps[i] = s == "." and "_" or s
    end
    local history_prefix = table.concat(seps, "_")
    local chat_history = path.join(aider_cach_path, history_prefix .. ".aider.chat.history.md")
    local input_history = path.join(aider_cach_path, history_prefix .. ".aider.input.history")
    table.insert(args, "--chat-history-file " .. chat_history)
    table.insert(args, "--input-history-file " .. input_history)
    if path.exists(chat_history) then
        table.insert(args, "--restore-chat-history")
    end

    -- get api_keys form rbw
    if vim.fn.executable("rbw") == 1 then
        local ok, openai_api_key = pcall(vim.fn.system, { "rbw", "get", "chutes-api" })
        if not ok then
            print("获取凭证失败:", openai_api_key)
            return
        end
        table.insert(args, "--openai-api-key " .. string.gsub(openai_api_key, "\n", ""))
    end

    opts.args = args
    orig_toggle(opts)
end
