vim.keymap.set("n", "<leader>ss", "", { desc = "[S]earch [S]nippets" })
vim.keymap.set("n", "<leader>sse", function()
	require("scissors").editSnippet()
end, { desc = "[S]nippet: [E]dit" })

-- when used in visual mode, prefills the selection as snippet body
vim.keymap.set({ "n", "x" }, "<leader>ssa", function()
	require("scissors").addNewSnippet()
end, { desc = "[S]nippet: [A]dd" })

return {
	"chrisgrieser/nvim-scissors",
	dependencies = "nvim-telescope/telescope.nvim", -- if using telescope
	opts = {
		snippetDir = vim.fn.stdpath("config") .. "/lua/config/snippets",
	},
}
