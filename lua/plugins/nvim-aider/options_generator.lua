local terminal = require("nvim_aider.terminal")
local path = require("utils.os.path")
local get_colors = require("themes.colors.manager").colors

----------------------------------------------------------------------
--                          util functions                          --
----------------------------------------------------------------------
-- color scheme
local function gen_color_scheme()
    local colors = get_colors()
    return {
        user_input_color = colors.base0B,
        tool_output_color = colors.base0D,
        tool_error_color = colors.base08,
        tool_warning_color = colors.base0A,
        assistant_output_color = colors.base05,
        completion_menu_color = colors.base07,
        completion_menu_bg_color = colors.base02,
        completion_menu_current_color = colors.base01,
        completion_menu_current_bg_color = colors.base03,
    }
end

-- Function to generate a 16-digit random password
local function generate_random_password(length)
    length = length or 16
    local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    local result = {}
    math.randomseed(os.time()) -- Ensure each generated password is unique

    for i = 1, length do
        local rand = math.random(1, #charset)
        table.insert(result, string.sub(charset, rand, rand))
    end

    return table.concat(result)
end

-- Function to save a string to a specified path
local function save_string_to_file(content, file_path)
    local dir = vim.fn.fnamemodify(file_path, ":h")
    if not path.exists(dir) then
        path.mkdir(dir)
    end

    local file = io.open(file_path, "w")
    if file then
        file:write(content)
        file:close()
        return true
    end
    return false
end

-- use gpg to add
local aider_key_encrypt_passfile = path.join(vim.fn.stdpath("state"), "aider", "encrypt_pass")
if not path.exists(vim.fn.fnamemodify(aider_key_encrypt_passfile, ":p:h")) then
    path.mkdir(vim.fn.fnamemodify(aider_key_encrypt_passfile, ":p:h"))
end
if not path.exists(aider_key_encrypt_passfile) then
    save_string_to_file(generate_random_password(), aider_key_encrypt_passfile)
end


----------------------------------------------------------------------
--                         config of models                         --
----------------------------------------------------------------------
local model_providers = {
    chutes = {
        api_base = "https://llm.chutes.ai/v1",
        model = "openai/deepseek-ai/DeepSeek-R1-0528",
        editor_model = "openai/deepseek-ai/DeepSeek-V3-0324"
    },
    cstcloud = {
        api_base = "https://uni-api.cstcloud.cn/v1",
        model = "openai/deepseek-r1:671b-0528",
        editor_model = "openai/deepseek-v3:671b"
    },
    openrouter = {
        model = "openrouter/deepseek/deepseek-r1-0528:free",
        editor_model = "openrouter/deepseek/deepseek-chat-v3-0324:free"
    }
}
----------------------------------------------------------------------
--          functions to generate aider execute parameters          --
----------------------------------------------------------------------
-- override snacks terminal's toggle function
local orig_toggle = terminal.toggle
function terminal.toggle(opts)
    opts.theme = gen_color_scheme()
    local provider = "openrouter"
    local args = {
        "--no-auto-commits",
        "--pretty",
        "--stream",
        "--watch-files",
        "--architect",
        "--model " .. model_providers[provider]["model"],
        "--editor-model " .. model_providers[provider]["editor_model"],
        "--editor-edit-format editor-diff",
        "--model-metadata-file " .. path.join(vim.fn.stdpath("config"), "extra", "aider-model-metadata.json"),
        "--code-theme one-dark"
    }
    if model_providers[provider]["api_base"] then
        table.insert(args, "--openai-api-base " .. model_providers[provider]["api_base"])
    end


    local aider_encrypt_key_file = path.join(vim.fn.stdpath("state"), "aider", provider .. "-api_key.asc")
    if not path.exists(aider_encrypt_key_file) then
        local key = vim.fn.input("Please input api key to continue use aider")
        local tmpfile = vim.fn.tempname()
        save_string_to_file(key, tmpfile)
        local gpg_encrypt_cmd = { "gpg", "-c", "--batch", "--passphrase-file", aider_key_encrypt_passfile, "-o",
            aider_encrypt_key_file, tmpfile }
        local ok, e = pcall(vim.fn.system, gpg_encrypt_cmd)
        if not ok then
            vim.notify("Saving api key to file error: " .. e, vim.log.levels.ERROR)
        end
    end

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
    -- if vim.fn.executable("rbw") == 1 then
    local gpg_decrypt_cmd = {
        "gpg", "-d", "-q", "--batch", "--passphrase-file", aider_key_encrypt_passfile,
        aider_encrypt_key_file
    }
    local ok, api_key = pcall(vim.fn.system, gpg_decrypt_cmd)

    -- local ok, openai_api_key = pcall(vim.fn.system, { "rbw", "get", "chutes-api" })
    if not ok then
        vim.notify("Failed to get credentials:" .. api_key, vim.log.levels.ERROR)
        return
    end
    if provider == "openrouter" then
        table.insert(args, "--set-env " .. " OPENROUTER_API_KEY=" .. string.gsub(api_key, "\n", ""))
    else
        table.insert(args, "--openai-api-key " .. string.gsub(api_key, "\n", ""))
    end


    opts.args = args
    orig_toggle(opts)
end
