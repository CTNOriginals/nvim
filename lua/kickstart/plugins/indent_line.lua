return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		config = function()
			vim.opt.list = true
			vim.opt.listchars:append("space: ")
			-- vim.opt.listchars:append "eol:↴"
			local highlight = {
				"RainbowBlue",
				"RainbowCyan",
				"RainbowGreen",
				-- "RainbowViolet",
				"RainbowYellow",
				"RainbowOrange",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
				"RainbowRed",
			}
			local selectHL = "SelectedHighLight"

			local hooks = require("ibl.hooks")
			-- create the highlight groups in the highlight setup hook, so they are reset
			-- every time the colorscheme changes
			hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
				vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#22dd44" })
				vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#22dddd" })
				vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#2244dd" })
				vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#8822dd" })
				vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#dddd22" })
				vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#dd8822" })
				vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#dd2222" })
				vim.api.nvim_set_hl(0, "SelectedHighLight", { fg = "#dddddd" })
			end)

			local status, ibl = pcall(require, "ibl")
			if not status then
				return
			end
			ibl.setup({
				scope = {
					highlight = selectHL,
				},
				indent = {
					char = "|",
					tab_char = {
						"▎",
						"▎",
						"▍",
						"▍",
						"▌",
						"▌",
						"▋",
						"▋",
						"▊",
						"▊",
						"▉",
						"▉",
						"█",
						"█",
					},
					highlight = highlight,
				},
			})
		end,

		-- opts = {
		-- 	indent = {
		-- 		char = "|",
		-- 		tab_char = { "▎", "▍", "▌", "▋", "▊", "▉", "█" },
		-- 		highlight = highlight,
		-- 	},
		-- },
	},
}
