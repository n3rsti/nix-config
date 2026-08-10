vim.pack.add({
	{
		src = "https://github.com/GCBallesteros/jupytext.nvim",
	},
})

require("jupytext").setup()

vim.pack.add({
	{
		src = "https://github.com/benlubas/molten-nvim",
		version = vim.version.range("1"),
	},
})

vim.g.molten_output_win_max_height = 12
