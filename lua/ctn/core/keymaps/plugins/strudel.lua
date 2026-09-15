local strudel = require("strudel")

local triggerKey = "<leader><cr>"

---@type table<string, keymapParams>
local keymaps = {
	launch = { "n", "l", strudel.launch, { desc = "Strude[l] [l]aunch" } },
	quit = { "n", "q", strudel.quit, { desc = "Strude[l] [q]uit" } },
	setBuf = { "n", "b", strudel.set_buffer, { desc = "Strude[l] [b]uffer" } },
	execute = { "n", "x", strudel.execute, { desc = "Strude[l] e[x]ecute" } },
	toggle = { "n", "<space>", strudel.toggle, { desc = "Strude[l] Play/Stop" } },
	update = { "n", "<cr>", strudel.update, { desc = "Strude[l] update" } },
	stop = { "n", "s", strudel.stop, { desc = "Strude[l] [s]top Playback" } },
}

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { "*.str", "*.std", "*.strudel" },
	callback = function()
		-- vim.schedule(function()
		vim.keymap.set("n", triggerKey, "", { desc = "Strude[l]", buf = 0 })

		for _, km in pairs(keymaps) do
			km[4].buf = 0
			vim.keymap.set(km[1], triggerKey .. km[2], km[3], km[4])
		end
		-- end)
	end,
})
