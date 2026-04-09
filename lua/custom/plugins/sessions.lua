-- vim.keymap.set("n", "<C-q>", ":Telescope find_files cwd=.nvim/sessions<CR>")
-- vim.keymap.set("n", "<C-q>", function()
--
-- end)

return {
	"natecraddock/sessions.nvim",
	opts = {
		session_filepath = ".nvim/sessions/default",
		events = { "WinEnter", "VimLeavePre" },
	},
}
