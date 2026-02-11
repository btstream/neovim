vim.opt.confirm = true
vim.cmd([[cnoreabbrev <silent> q <cmd>lua require("utils.window").quit()<cr>]])
vim.cmd([[cnoreabbrev <silent> x <cmd>lua require("utils.file").save_file()<cr><cmd>quitall<cr>]])
