local M = {}

local ESCAPES_QUERY = [[
	(escape_sequence) @escape
]]

function M.setup(bufnr)
	local ns = vim.api.nvim_create_namespace("cthemen_go_escapes")
	local ok, q = pcall(vim.treesitter.query.parse, "go", ESCAPES_QUERY)

	local apply = function(r)
		if not ok then
			return
		end
		for _, node in q:iter_captures(r, bufnr, 0, -1) do
			local sr, sc, er, ec = node:range()
			vim.api.nvim_buf_set_extmark(bufnr, ns, sr, sc, {
				end_row = er,
				end_col = ec,
				hl_group = "@string.escape",
				priority = 200,
			})
		end
	end

	return apply, ns
end

return M
