local M = {}

local function root_of(bufnr, lang)
	local parser = vim.treesitter.get_parser(bufnr, lang)
	if not parser then
		return
	end
	local tree = parser:parse()[1]
	return tree and tree:root()
end

local function setup_language(pattern, lang, lsp_overrides, overrides)
	vim.api.nvim_create_autocmd("LspAttach", {
		pattern = pattern,
		callback = function(args)
			local bufnr = args.buf

			for _, hl in ipairs(lsp_overrides) do
				vim.api.nvim_set_hl(0, hl, {})
			end

			local fns = {}
			local nss = {}
			for _, mod in ipairs(overrides) do
				local apply, ns = mod.setup(bufnr)
				table.insert(fns, apply)
				table.insert(nss, ns)
			end

			local function update()
				local r = root_of(bufnr, lang)
				if not r then
					return
				end
				for _, ns in ipairs(nss) do
					vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
				end
				for _, fn in ipairs(fns) do
					fn(r)
				end
			end

			update()
			vim.api.nvim_create_autocmd("TextChanged", { buffer = bufnr, callback = update })
			vim.api.nvim_create_autocmd("TextChangedI", { buffer = bufnr, callback = update })
		end,
	})
end

function M.setup()
	setup_language("*.go", "go", {
		"@lsp.type.variable.go",
		"@lsp.typemod.variable.defaultLibrary.go",
	}, {
		require("cthemen.overrides.go.builtins"),
		require("cthemen.overrides.go.receiver"),
	})
end

return M
