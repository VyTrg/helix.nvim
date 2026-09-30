local M = {}

local defaults = require("helix.defaults")

function M.setup(opts)
	local opts = vim.tbl_deep_extend("force", defaults, opts or {})

	require("helix.keybinds").setup(opts)

	if opts.full and package.loaded["which-key"] ~= nil then
		require("helix.which-key-integration")
	end
end

return M
