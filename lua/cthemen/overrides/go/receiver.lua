local M = {}

local RECEIVER_QUERY = [[
	(method_declaration
	  receiver: (parameter_list
	    (parameter_declaration name: (identifier) @receiver.name))
	  body: (block) @receiver.body)
]]

local IDENT_QUERY = [[(identifier) @id]]

local function collect_pairs(r, bufnr, r_q)
	local pairs = {}
	local pending
	for id, node in r_q:iter_captures(r, bufnr, 0, -1) do
		local cap = r_q.captures[id]
		if cap == "receiver.name" then
			pending = { text = vim.treesitter.get_node_text(node, bufnr) }
		elseif cap == "receiver.body" and pending then
			table.insert(pairs, { name = pending.text, sr = node:start(), er = node:end_() })
			pending = nil
		end
	end
	return pairs
end

local function find_pair(pairs, text, sr)
	for _, pair in ipairs(pairs) do
		if text == pair.name and sr >= pair.sr and sr < pair.er then
			return pair
		end
	end
end

local function mark_references(r, bufnr, i_q, pairs, ns)
	for id, node in i_q:iter_captures(r, bufnr, 0, -1) do
		local text = vim.treesitter.get_node_text(node, bufnr)
		local sr, sc, er, ec = node:range()
		if find_pair(pairs, text, sr) then
			vim.api.nvim_buf_set_extmark(bufnr, ns, sr, sc, {
				end_row = er,
				end_col = ec,
				hl_group = "@go.receiver",
				priority = 150,
			})
		end
	end
end

function M.setup(bufnr)
	local ns = vim.api.nvim_create_namespace("cthemen_go_receiver")
	local r_ok, r_q = pcall(vim.treesitter.query.parse, "go", RECEIVER_QUERY)
	local i_ok, i_q = pcall(vim.treesitter.query.parse, "go", IDENT_QUERY)

	local apply = function(r)
		if not (r_ok and i_ok) then
			return
		end
		local pairs = collect_pairs(r, bufnr, r_q)
		mark_references(r, bufnr, i_q, pairs, ns)
	end

	return apply, ns
end

return M
