local forward_search = {}
if vim.fn.executable("okular") == 1 then
    forward_search = {
        executable = 'okular',
        args = { '--unique', 'file:%p#src:%l%f' },
    }
end

return {
    settings = {
        texlab = {
            bibtexFormatter = "texlab",
            build = {
                args = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
                executable = "latexmk",
                forwardSearchAfter = not vim.tbl_isempty(forward_search),
                onSave = true
            },
            chktex = {
                onEdit = false,
                onOpenAndSave = false
            },
            diagnosticsDelay = 300,
            formatterLineLength = 80,
            forwardSearch = forward_search,
            latexFormatter = "latexindent",
            latexindent = {
                modifyLineBreaks = false
            }
        }
    }
}
