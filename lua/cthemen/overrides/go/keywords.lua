local M = {}

local KEYWORDS_QUERY = [[
  "break" @keyword.repeat
  "continue" @keyword.repeat
  "goto" @keyword.repeat
  "fallthrough" @keyword.repeat
  "range" @keyword.repeat
  "defer" @keyword.coroutine
  "select" @keyword.coroutine
  "const" @keyword.storage
  "var" @keyword.storage
  "default" @keyword.conditional
]]

function M.setup(bufnr)
	local ns = vim.api.nvim_create_namespace("cthemen_go_keywords")
	local ok, q = pcall(vim.treesitter.query.parse, "go", KEYWORDS_QUERY)

	local apply = function(r)
		if not ok then
			return
		end
		for id, node in q:iter_captures(r, bufnr, 0, -1) do
			local hl = "@" .. q.captures[id]
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
