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
		local bufnr = args.buf

		-- Don't let LSP highlight Go variables at all — tree-sitter handles
		-- basic variable coloring. We only need LSP for the @constant modifier
		-- (which identifies user-declared const references).
		vim.api.nvim_set_hl(0, "@lsp.type.variable.go", {})
		-- Prevent stdlib identifiers (fmt.Println, etc.) from getting c.builtin.
		-- We only want c.builtin for the predeclared identifiers true/false/nil/iota.
		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.go", {})

		-- The problem: gopls emits @lsp.typemod.variable.readonly for BOTH
		-- user constants and predeclared builtins (true/false/nil/iota). Since
		-- LSP semantic tokens have priority ~125-127 and tree-sitter only 100,
		-- tree-sitter captures of these nodes get overridden and all look the same.
		--
		-- The fix: apply our own extmarks at priority 150 for these specific
		-- builtin nodes using tree-sitter queries, which wins over LSP.
		local ns = vim.api.nvim_create_namespace("cthemen_go_builtins")
		local ok, query = pcall(
			vim.treesitter.query.parse,
			"go",
			[[
			(true) @boolean
			(false) @boolean
			(nil) @constant.builtin
			(iota) @constant.builtin
		]]
		)
		if not ok then
			return
		end

		-- Clear old extmarks, re-parse the tree, and apply new extmarks
		-- at priority 150 for every builtin node in the buffer.
		local function apply()
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
			local parser = vim.treesitter.get_parser(bufnr, "go")
			if not parser then
				return
			end
			local tree = parser:parse()[1]
			if not tree then
				return
			end

			for id, node in query:iter_captures(tree:root(), bufnr, 0, -1) do
				local hl = query.captures[id] == "boolean" and "@boolean" or "@constant.builtin"
				local sr, sc, er, ec = node:range()
				vim.api.nvim_buf_set_extmark(bufnr, ns, sr, sc, {
					end_row = er,
					end_col = ec,
					hl_group = hl,
					priority = 150,
				})
			end
		end

		apply()
		-- Re-apply on text changes since tree-sitter re-parses the buffer.
		vim.api.nvim_create_autocmd("TextChanged", { buffer = bufnr, callback = apply })
		vim.api.nvim_create_autocmd("TextChangedI", { buffer = bufnr, callback = apply })
	end,
})

vim.g.colors_name = "cthemen"
