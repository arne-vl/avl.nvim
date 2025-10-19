local M = {}

local config = {}

M.setup = function(opts)
	config = vim.tbl_extend("force", config, opts or {})
end

return M
