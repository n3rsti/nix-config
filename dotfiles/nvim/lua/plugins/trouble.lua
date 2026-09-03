vim.pack.add({
	"https://github.com/folke/trouble.nvim",
})

require("trouble").setup({
	warn_no_results = false,
	focus = true,
})

vim.keymap.set("n", "<leader>tt", function()
	require("trouble").toggle("diagnostics")
end)

vim.keymap.set("n", "]t", function()
	require("trouble").next({
		mode = "diagnostics",
		jump = true,
	})
end)

vim.keymap.set("n", "[t", function()
	require("trouble").prev({
		mode = "diagnostics",
		jump = true,
	})
end)
