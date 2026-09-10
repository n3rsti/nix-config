require("plugins.highlighting")

vim.pack.add({
	"https://github.com/3rd/image.nvim",
	{ src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim", version = vim.version.range("1.*") },
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/j-hui/fidget.nvim",
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/mfussenegger/nvim-dap-python",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/NOSDuco/remote-sshfs.nvim",
	"https://github.com/rachartier/tiny-cmdline.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/rose-pine/neovim",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
	"https://github.com/stevearc/conform.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/yioneko/telescope-fzy-native.nvim",
	"https://github.com/folke/lazydev.nvim",
})

require("rose-pine").setup({
	palette = { main = { base = "#111111" } },
	highlight_groups = {
		TelescopeNormal = { bg = "base" },
		TelescopeBorder = { fg = "highlight_high", bg = "base" },
		NormalFloat = { bg = "base" },
		FloatBorder = { bg = "base" },
		Pmenu = { bg = "base" },
		BlinkCmpDoc = { bg = "base" },
		BlinkCmpDocBorder = { bg = "base" },
	},
})
vim.cmd.colorscheme("rose-pine")

require("mini.pairs").setup()
require("mini.cursorword").setup()
require("mini.surround").setup()
require("mini.jump").setup()
require("mini.ai").setup()
require("ibl").setup()

require("oil").setup({
	win_options = { wrap = true, foldcolumn = "2" },
	keymaps = {
		["<Esc>"] = "actions.close",
		["<C-b>"] = "actions.close",
	},
})
vim.keymap.set("n", "<C-b>", require("oil").open, { desc = "Open Oil" })

require("remote-sshfs").setup()

local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
telescope.setup({
	pickers = {
		buffers = { sort_mru = true, ignore_current_buffer = true },
	},
})
telescope.load_extension("fzy_native")
telescope.load_extension("remote-sshfs")

local telescope_maps = {
	{ "<leader>sf", telescope_builtin.find_files, "Find files" },
	{ "<leader>sg", telescope_builtin.live_grep, "Live grep" },
	{ "<leader><leader>", telescope_builtin.buffers, "Find buffers" },
	{ "<leader>fh", telescope_builtin.help_tags, "Help tags" },
	{ "<leader>sk", telescope_builtin.keymaps, "Search keymaps" },
	{ "<C-p>", telescope_builtin.lsp_document_symbols, "Document symbols" },
	{ "<leader>/", telescope_builtin.current_buffer_fuzzy_find, "Search current buffer" },
}
for _, mapping in ipairs(telescope_maps) do
	vim.keymap.set("n", mapping[1], mapping[2], { desc = mapping[3] })
end

require("gitsigns").setup({
	signs = {
		add = { text = "|" },
		change = { text = "|" },
		delete = { text = "|" },
		topdelete = { text = "|" },
		changedelete = { text = "|" },
	},
})

require("plugins.lsp")
require("plugins.formatting")

local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end, { desc = "Harpoon add file" })
vim.keymap.set("n", "<C-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon menu" })
for index = 1, 9 do
	local target = index
	vim.keymap.set("n", "<leader>" .. index, function()
		harpoon:list():select(target)
	end, { desc = "Harpoon file " .. index })
end
vim.keymap.set("n", "<C-j>", function()
	harpoon:list():prev()
end, { desc = "Previous Harpoon file" })
vim.keymap.set("n", "<C-k>", function()
	harpoon:list():next()
end, { desc = "Next Harpoon file" })

require("image").setup()
require("typst-preview").setup({
	dependencies_bin = { tinymist = "tinymist", websocat = "websocat" },
})

require("plugins.debugging")

require("vim._core.ui2").enable({})
vim.o.cmdheight = 0
local cmdline = require("tiny-cmdline")
cmdline.setup({
	on_reposition = cmdline.adapters.blink,
	width = { value = "70%" },
})
