local M = {}

local BUILTINS_QUERY = [[
	(true) @boolean
	(false) @boolean
	(nil) @constant.builtin
	(iota) @constant.builtin
]]

function M.setup(bufnr)
	local ns = vim.api.nvim_create_namespace("cthemen_go_builtins")
	local ok, q = pcall(vim.treesitter.query.parse, "go", BUILTINS_QUERY)

	local apply = function(r)
		if not ok then return end
		for id, node in q:iter_captures(r, bufnr, 0, -1) do
			local hl = q.captures[id] == "boolean" and "@boolean" or "@constant.builtin"
			local sr, sc, er, ec = node:range()
			vim.api.nvim_buf_set_extmark(bufnr, ns, sr, sc, {
				end_row = er,
				end_col = ec,
				hl_group = hl,
				priority = 150,
			})
		end
	end

	return apply, ns
end

return M
