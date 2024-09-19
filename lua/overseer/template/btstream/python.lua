return {
    name = "Run python script",
    builder = function()
        local file = vim.fn.expand("%:p")

        local cmd = {}
        for _, python in pairs({ "python", "python3" }) do
            if vim.fn.executable(python) then
                cmd = { python }
                break
            end
        end

        -- TODO: add support for virtualenv
        -- local python_root = vim.fs.root(0, { "pyproject.toml", "setup.py", ".venv", ".virtualenv" })
        return {
            cmd = cmd,
            args = { file },
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
    condition = {
        filetype = { "python" },
    },
}
