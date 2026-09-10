vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.diagnostic.config({
	virtual_text = true,
	signs = false,
})

vim.o.updatetime = 50
vim.o.signcolumn = "yes"
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.swapfile = false
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.undofile = true
vim.o.winborder = "rounded"
vim.o.scrolloff = 10
vim.o.wrap = false
vim.o.exrc = true

local function set_highlights()
	vim.api.nvim_set_hl(0, "LineNr", { fg = "#8a8c8e" })
	vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "LspReferenceWrite" })
	vim.api.nvim_set_hl(0, "MiniCursorword", { link = "LspReferenceWrite" })
end
set_highlights()
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.filetype.add({
	extension = { razor = "razor" },
})

local function map(mode, keys, action, desc)
	vim.keymap.set(mode, keys, action, { desc = desc })
end

map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("x", "<", "<gv", "Indent selection left")
map("x", ">", ">gv", "Indent selection right")
map("n", "J", "mzJ`z", "Join lines without moving cursor")
map("n", "<C-d>", "<C-d>zz", "Scroll down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll up and center")
map("i", "<C-h>", "<Left>", "Move cursor left")
map("i", "<C-l>", "<Right>", "Move cursor right")
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")
map("n", "<leader>e", vim.diagnostic.open_float, "Open diagnostics")
map("n", "<Right>", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, "Next diagnostic")
map("n", "<Left>", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, "Previous diagnostic")
map("n", "<Up>", vim.cmd.copen, "Open quickfix list")
map("n", "<Down>", vim.cmd.cclose, "Close quickfix list")
map("n", "<leader>yp", function()
	local path = vim.fn.expand("%:p")
	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end
	vim.fn.setreg("+", path)
	vim.notify("Copied: " .. path)
end, "Copy current file path")

local terminal = { buf = -1, win = -1 }

local function toggle_terminal()
	if vim.api.nvim_win_is_valid(terminal.win) then
		vim.api.nvim_win_hide(terminal.win)
		return
	end

	if not vim.api.nvim_buf_is_valid(terminal.buf) then
		terminal.buf = vim.api.nvim_create_buf(false, true)
	end

	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	terminal.win = vim.api.nvim_open_win(terminal.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		col = math.floor((vim.o.columns - width) / 2),
		row = math.floor((vim.o.lines - height) / 2),
		style = "minimal",
		border = "rounded",
	})

	if vim.bo[terminal.buf].buftype ~= "terminal" then
		vim.cmd.terminal()
	end
end

vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Enter normal mode")
map({ "n", "i", "t" }, "<C-t>", function()
	local mode = vim.api.nvim_get_mode().mode
	toggle_terminal()
	if mode == "n" then
		vim.cmd.startinsert()
	end
end, "Toggle floating terminal")
