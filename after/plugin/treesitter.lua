-- Ensure parsers are installed (async, no-op if present)
require("nvim-treesitter").install({
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

vim.api.nvim_set_keymap("n", "<leader>`", "<cmd>Inspect<cr>", {
	noremap = true,
})
