-- so treesitter finds queries/go/*.scm
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/cthemen")

local c = require("cthemen.palette")

require("cthemen.highlights").setup(c)
require("cthemen.syntax").setup(c)
require("cthemen.treesitter").setup(c)
require("cthemen.plugins").setup(c)

vim.api.nvim_create_autocmd("LspAttach", {
	pattern = "*.go",
	callback = function(args)
		vim.api.nvim_set_hl(0, "@lsp.type.variable.go", {})
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.go", {})
		-- vim.api.nvim_set_hl(0, "@lsp.type.keyword.go", {})
		-- vim.lsp.semantic_tokens.enable(false, { bufnr = args.buf })
	end,
})

vim.g.colors_name = "cthemen"
