vim.filetype.add({
	extension = {
		conv = "conveycode",
		mlog = "mlog",
	},
})

_G.ConveycodeIndent = function(lnum)
	local prevlnum = vim.fn.prevnonblank(lnum - 1)
	if prevlnum == 0 then
		return 0
	end

	local sw = vim.fn.shiftwidth()
	local indent = vim.fn.indent(prevlnum)

	local prevline = vim.fn.getline(prevlnum):gsub("%s+$", "")
	local lastchar = prevline:sub(-1)
	if lastchar == "{" or lastchar == "(" or lastchar == "[" then
		indent = indent + sw
	end

	local curline = vim.fn.getline(lnum):gsub("^%s+", "")
	local firstchar = curline:sub(1, 1)
	if firstchar == "}" or firstchar == ")" or firstchar == "]" then
		indent = indent - sw
	end

	return indent
end

vim.api.nvim_create_autocmd("FileType", {
	desc = "Set commentstring and block-scope indenting for conveycode",
	pattern = "conveycode",
	callback = function()
		vim.bo.commentstring = "// %s"
		vim.bo.indentexpr = "v:lua.ConveycodeIndent(v:lnum)"
		vim.bo.indentkeys = "0{,0},0),0],!^F,o,O"
	end,
})

vim.o.autoread = true

-- CursorHold only fires once per idle period (by design), so it goes silent
-- if the window sits unfocused/untouched. A plain timer keeps checking
-- regardless of focus or input.
vim.uv.new_timer():start(
	1000,
	1000,
	vim.schedule_wrap(function()
		vim.cmd("checktime")
	end)
)

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
	desc = "Reload buffers changed on disk immediately on refocus",
	callback = function()
		vim.cmd("checktime")
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Store yanked text in system clipboard",
	group = vim.api.nvim_create_augroup("yank-to-clipboard", { clear = true }),
	callback = function()
		vim.cmd("let @+=@0")
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = { only = { "source.organizeImports" } }
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end
		vim.lsp.buf.format({ async = false })
	end,
})
