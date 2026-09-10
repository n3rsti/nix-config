local M = {
	items = {},
}

function M.add(name, action, keys)
	M.items[name] = {
		name = name,
		keys = keys,
		action = action,
	}
end

function M.map(keys, action, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, keys, action, { desc = desc })
	M.add(desc, action, keys)
end

return M
