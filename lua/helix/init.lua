-- ============================================================================
-- WARNING: helix.nvim is in early development and not yet officially released.
-- Features, APIs, and keybindings are subject to breaking changes.
-- ============================================================================

local M = {}

local defaults = require("helix.defaults")

function M.setup(opts)
	local opts = vim.tbl_deep_extend("force", defaults, opts or {})

	require("helix.keybinds").setup(opts)

	if opts.full and opts.which_key_integration then
		local ok, _ = pcall(require, "which-key")
		if ok then
			require("helix.which-key-integration")
		end
	end
end

return M
