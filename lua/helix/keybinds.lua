local M = {}

local utils = require("helix.utils")

function M.setup(opts)
	local opts = opts or {}

	if opts.full then
		local movement = { "h", "j", "k", "l" }
		local word = { "w", "e", "b" }

		utils.keymap.set(movement, { presets = { "deselect", "extend" } })
		utils.keymap.set(word, { presets = { "reselect", "extend", "alternate" } })
		utils.keymap.set({ "f", "t" }, { presets = { "reselect", "extend", "alternate_extend" }, getcharstr = true })

		utils.keymap.set({ { "<A-h>", "0" }, { "<A-l>", "$" } }, { presets = { "reselect" }, countable = false })
		utils.keymap.set(
			{ { "gh", "0" }, { "gl", "$" } },
			{ presets = { "deselect", "goto_extend" }, countable = false }
		)
		utils.keymap.set({
			{ "gg", "gg0" },
			{ "ge", "G$" },
			{ "gj", "G" },
			{ "gk", "gg" },

			{ "gt", "H" },
			{ "gc", "M" },
			{ "gb", "L" },
		}, { presets = { "deselect", "goto_extend" }, countable = false })
		vim.keymap.set({ "n", "x" }, "G", "", { desc = "Goto extend" })

		utils.keymap.set({ { "<A-j>", "J" } }, { presets = { "none" }, opts = { desc = "Join lines" } })

		-- paste
		utils.keymap.set({ "p", "P" }, { presets = { "put" } })
		utils.keymap.set({ { "R", "p" } }, { presets = { "extend" } })

		for _, key in ipairs({ "i", "a" }) do
			local wrapped_key = utils.wrap_key(key)
			local rhs = "v" .. key
			local v_rhs = utils.keycode("<Esc>") .. rhs
			vim.keymap.set("n", wrapped_key, rhs)
			vim.keymap.set("x", wrapped_key, v_rhs)

			if opts.experimental.rebind_visual_aiAI then
				utils.keymap.set(key, { presets = { "around_inside" } })

				local upper_key = string.upper(key)
				vim.keymap.set("x", upper_key, "<Esc>" .. upper_key)
			end
		end
		if opts.experimental.rebind_visual_aiAI then
			vim.keymap.set("x", "i", "<Esc>`<i")
			vim.keymap.set("x", "a", "<Esc>`>a")
		end

		for _, key in ipairs({ { "o", ">" }, { "O", "<" } }) do
			vim.keymap.set("x", key[1], "<Esc>`" .. key[2] .. key[1])
			vim.keymap.set("n", utils.wrap_key(key[1]), "<Esc>v<Esc>" .. key[1] .. "<Esc>gv<Esc>")
			vim.keymap.set("x", utils.wrap_key(key[1]), "<Esc>`" .. key[2] .. key[1] .. "<Esc>gv")
		end
		utils.keymap.set({ { "<A-;>", "o" } }, { presets = { "nonormal" } })

		-- select all (Helix style)
		vim.keymap.set({ "n", "x" }, "%", "ggVG", { desc = "Select all (Helix style)", remap = false })

		-- choose with '' quote
		-- Note: use mode 'x' instead of 'v' so it does not override Select mode in LazyVim (used by snippet engines)
		vim.keymap.set({ "x", "o" }, "i'", "i'", { desc = "Inside single quote", remap = false })
		vim.keymap.set({ "x", "o" }, "a'", "a'", { desc = "Around single quote", remap = false })

		-- helix comment toggle
		vim.keymap.set("n", "<C-c>", "gcc", { remap = true, desc = "Toggle comment line" })
		vim.keymap.set("x", "<C-c>", "gc", { remap = true, desc = "Toggle comment selection" })
	end

	for _, key in ipairs({ "d", "c", "y" }) do
		vim.keymap.set({ "n" }, key, "v" .. key)
	end
	vim.keymap.set({ "n", "x" }, "x", "V")
end

return M
