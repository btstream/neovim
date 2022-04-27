local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
local Path = require("plenary.path")
local codelldb_path = dbg_path .. "extension/adapter/codelldb"
local liblldb_path = dbg_path .. "extension/lldb/lib/liblldb.so"
local dap = {}
if Path:new(codelldb_path):exists() then
	dap = { adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path) }
end
return dap
