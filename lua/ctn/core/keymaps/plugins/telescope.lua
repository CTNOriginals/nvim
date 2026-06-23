local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[s]earch [h]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[s]earch [k]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[s]earch [f]iles" })
vim.keymap.set("n", "<leader>st", builtin.builtin, { desc = "[s]earch select [t]elescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[s]earch current [w]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[s]earch by [g]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[s]earch [d]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[s]earch [r]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[s]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[s]earch [/] in Open Files" })

vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[s]earch [n]eovim files" })

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

-- vim.defer_fn(function()
-- 	if vim.fn.getcwd() ~= "/home/ctn/.config/dotfiles" then
-- 		return
-- 	end
-- 	prototyper()
-- end, 100)

-- print("here!")
