return {
    settings = {
        Lua = {
            format = {
                enable = true,
                defaultConfig = {
                    indent_style = "space",
                    indent_size = 4,
                    max_line_length = 240,
                    continuation_indent = "4",
                    align_continuous_assign_statement = true,
                    call_arg_parentheses = "always",
                    space_before_closure_open_parenthesis = "false",
                    quote_style = "double",
                    align_call_args = "true",
                },
            },
            diagnostics = { globals = { "vim" }, disable = { "unused-vararg" } },
            workspace = { checkThirdParty = false, maxPreload = 1000 },
            hint = { enable = true, setType = true },
            runtime = { version = "LuaJIT" },
        },
    },
}
