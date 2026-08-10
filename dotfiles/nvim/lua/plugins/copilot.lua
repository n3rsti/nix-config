vim.pack.add({
	"https://github.com/github/copilot.vim",
})

vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
	expr = true,
	replace_keycodes = false,
})
