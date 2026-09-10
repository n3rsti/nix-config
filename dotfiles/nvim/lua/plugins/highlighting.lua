vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		local data = event.data
		if data.spec.name == "nvim-treesitter" and (data.kind == "install" or data.kind == "update") then
			if not data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd.TSUpdate()
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local treesitter = require("nvim-treesitter")
		local language = vim.treesitter.language.get_lang(args.match) or args.match
		if vim.tbl_contains(treesitter.get_installed("parsers"), language) then
			vim.treesitter.start(args.buf, language)
			vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		elseif vim.tbl_contains(treesitter.get_available(), language) then
			treesitter.install(language)
		end
	end,
})
