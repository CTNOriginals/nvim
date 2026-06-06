return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = false,
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false,
	keys = {
		{ "\\", ":Neotree reveal<CR>", desc = "NeoTree reveal", silent = true },
	},
	opts = {
		filesystem = {
			window = {
				mappings = {
					["\\"] = "close_window",
				},
			},
		},
		window = {
			position = "right",
		},
		source_selector = {
			winbar = true,
			statusline = false,
		},
	},
}
