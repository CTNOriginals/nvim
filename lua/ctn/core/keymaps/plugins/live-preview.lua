-- local lp = require("livepreview")

local triggerKey = "<leader>l"
local descPrefix = "[l]ive Preview"

---@type table<string, keymapParams>
local keymaps = {
	start = { "n", "s", "LivePreview start", { desc = "[s]tart" } },
	close = { "n", "c", "LivePreview close", { desc = "[c]lose" } },
	pick = { "n", "p", "LivePreview pick", { desc = "[p]ick" } },
	help = { "n", "h", "LivePreview help", { desc = "[h]elp" } },
}

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = {
		"*.html",
		"*.md",
		"*.svg",
		"*.css",
		"*.scss",
		"*.js",
		"*.ts",
	},
	callback = function()
		-- vim.schedule(function()
		vim.keymap.set("n", triggerKey, "", { desc = descPrefix, buf = 0 })

		for _, km in pairs(keymaps) do
			km[4].buf = 0
			vim.keymap.set(km[1], triggerKey .. km[2], function()
				vim.cmd(km[3])
			end, km[4])
		end
		-- end)
	end,
})
