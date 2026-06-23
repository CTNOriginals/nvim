---@class findFilesArgs
---@field field string
---@field value boolean
---@field key string

---@type findFilesArgs[]
local findFilesDefaults = {
	{ field = "follow", value = false, key = "f" },
	{ field = "hidden", value = false, key = "h" },
	{ field = "no_ignore", value = false, key = "i" },
	{ field = "no_ignore_parent", value = false, key = "p" },
}

---@type telescope.builtin.find_files.opts
local findFilesOpts = {
	bufnr = 0,
	winnr = 0,
}

findFilesOpts.hidden = false

local findFileArgsSubmited = false

vim.keymap.set("n", "<leader>sc", function()
	findFileArgsSubmited = false
end, { desc = "[s]earch [c]ustom" })

vim.keymap.set("n", "<leader>sc<cr>", function()
	findFileArgsSubmited = true
end, { desc = "submit" })
vim.keymap.set("n", "<leader>sc<esc>", function()
	findFileArgsSubmited = true
end, { desc = "cancel" })

local whichkey = require("which-key")

for _, arg in ipairs(findFilesDefaults) do
	vim.keymap.set("n", "<leader>sc" .. arg.key, "", {
		desc = arg.field .. ": " .. tostring(arg.value),
		callback = function()
			findFilesOpts[arg.field] = not findFilesOpts[arg.field] or arg.value

			local current = ""
			for _, arg2 in ipairs(findFilesDefaults) do
				current = current .. arg2.field .. ": " .. tostring(findFilesOpts[arg2.field]) .. ", "
				whichkey.add()
			end

			print(current)
			whichkey.show("<leader>sc")
		end,
	})

	whichkey.add("")
end

vim.defer_fn(function()
	whichkey.show("<leader>sc")
end, 300)

local function prototyper()
	-- local path = getPath()
	builtin.find_files({
		hidden = true,
		-- no_ignore = true,
		no_ignore_parent = true,
		follow = true,
	})
end

vim.keymap.set("n", "<leader>sj", function()
	prototyper()
end, { desc = "[s]earch TEST" })
