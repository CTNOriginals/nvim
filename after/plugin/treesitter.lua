-- Ensure parsers are installed (async, no-op if present)
pcall(function()
	require("nvim-treesitter.install").ensure_installed({
		"bash",
		"c",
		"diff",
		"html",
		"lua",
		"luadoc",
		"markdown",
		"markdown_inline",
		"query",
		"vim",
		"vimdoc",
		"go",
	})
end)

-- Enable treesitter highlighting with large-file guard
local ts_disabled = { help = true, Help = true, ruby = true }
vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		if ts_disabled[vim.bo[args.buf].filetype] then
			return
		end
		local max_filesize = 300 * 1024
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > max_filesize then
			return
		end
		pcall(vim.treesitter.start, args.buf)
	end,
})

vim.keymap.set("n", "<leader>ts", "", { desc = "[T]ree[S]itter" })
vim.keymap.set("n", "<leader>tsi", "<cmd>Inspect<cr>", { desc = "[T]ree[S]itter [I]nspect" })
vim.keymap.set("n", "<leader>tst", "<cmd>InspectTree<cr>", { desc = "[T]ree[S]itter Inspect [T]ree" })

-- vim.api.nvim_create_autocmd("User", {
-- pattern = "TSUpdate",
-- callback = function()
-- 	require("nvim-treesitter.parsers").go.install_info.queries = true
-- end,
-- })
