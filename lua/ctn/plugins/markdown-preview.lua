return {
	"selimacerbas/markdown-preview.nvim",
	dependencies = { "selimacerbas/live-server.nvim" },
	config = function()
		require("markdown_preview").setup({
			instance_mode = "takeover",
			port = 0,
			open_browser = true,
			debounce_ms = 300,
		})
	end,
}
