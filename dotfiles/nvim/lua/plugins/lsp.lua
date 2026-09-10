require("fidget").setup()
require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<S-Tab>"] = { "select_prev", "fallback" },
		["<Tab>"] = { "select_next", "fallback" },
	},
	completion = {
		trigger = { show_on_blocked_trigger_characters = { " ", "\n", "\t", ">", "}" } },
		documentation = { auto_show = true, auto_show_delay_ms = 0 },
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "source_name", "kind", gap = 1 },
				},
				components = {
					source_name = {
						width = { max = 30 },
						text = function(context)
							return "[" .. context.source_name .. "]"
						end,
						highlight = "BlinkCmpSource",
					},
				},
			},
		},
	},
	sources = {
		default = { "lazydev", "lsp", "path", "snippets", "buffer" },
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
	signature = { enabled = true },
})

local servers = {
	"air",
	"angularls",
	"bashls",
	"basedpyright",
	"blueprint_ls",
	"clangd",
	"cssls",
	"emmet_ls",
	"eslint",
	"gopls",
	"html",
	"jdtls",
	"jsonls",
	"kotlin_language_server",
	"lua_ls",
	"nil_ls",
	"qmlls",
	"r_language_server",
	"roslyn_ls",
	"rust_analyzer",
	"tailwindcss",
	"texlab",
	"tinymist",
	"vhdl_ls",
	"vtsls",
	"vue_ls",
	"zls",
}
for _, server in ipairs(servers) do
	vim.lsp.enable(server)
end

local telescope = require("telescope.builtin")
vim.keymap.set("n", "gd", telescope.lsp_definitions, { desc = "Go to definition" })
vim.keymap.set("n", "grr", telescope.lsp_references, { desc = "References" })
vim.keymap.set("n", "gi", telescope.lsp_implementations, { desc = "Go to implementation" })
vim.keymap.set("n", "grt", telescope.lsp_type_definitions, { desc = "Go to type definition" })
