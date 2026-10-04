local utils = require("helix.utils")
local wk = require("which-key")

local function text_objects()
	local ok, presets = pcall(require, "which-key.plugins.presets")
	if not ok or not presets.text_objects then
		return
	end
	local wk_text_objects = presets.text_objects
	if not vim.tbl_contains(wk_text_objects.mode or {}, "n") then
		table.insert(wk_text_objects.mode, "n")
	end

	for _, keybind in ipairs(wk_text_objects) do
		local keybind_str = keybind[1]
		if keybind_str and not vim.startswith(keybind_str, "<A-") then
			if string.len(keybind_str) == 1 then
				keybind[1] = "<A-" .. keybind_str .. ">"
			else
				keybind[1] = "<A-" .. string.sub(keybind_str, 1, 1) .. ">" .. string.sub(keybind_str, 2)
			end
		end
	end
end

local function goto_extend()
	local ok, presets = pcall(require, "which-key.plugins.presets")
	if ok and presets.motions then
		for _, val in ipairs(presets.motions) do
			if val[1] == "G" then
				val.desc = nil
				val.group = "Goto extend"
				val[2] = function()
					require("which-key").show({ keys = "G" })
				end
				break
			end
		end
	end

	local keys = {
		{ "gg", desc = "Go to buffer start" },
		{ "ge", desc = "Go to buffer end" },
		{ "gj", desc = "Go to first line of buffer" },
		{ "gk", desc = "Go to last line of buffer" },
		{ "gt", desc = "Go to top of view" },
		{ "gc", desc = "Go to center of view" },
		{ "gb", desc = "Go to bottom of view" },
		{ "gh", desc = "Go all the way to the left of the current line" },
		{ "gl", desc = "Go all the way to the right of the current line" },
	}

	local specs = {
		mode = { "n", "x" },
		{ "%", desc = "Select all (Helix style)" },
		{ "<C-c>", desc = "Toggle comment" },
	}
	for _, key in ipairs(keys) do
		table.insert(specs, vim.deepcopy(key))
		local key_extend = vim.deepcopy(key)
		key_extend[1] = utils.keymap.presets.goto_extend.Lhs_key_func(key[1])
		table.insert(specs, key_extend)
	end

	wk.add(specs)
end

text_objects()
goto_extend()
