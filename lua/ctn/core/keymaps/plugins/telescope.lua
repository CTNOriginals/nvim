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
	{ field = "follow", value = true, key = "f" },
	{ field = "hidden", value = true, key = "h" },
	{ field = "no_ignore", value = true, key = "i" },
}

---@type telescope.builtin.find_files.opts
local findFilesOpts = {
	bufnr = 0,
	winnr = 0,
}

local findFileArgsSubmited = false

vim.keymap.set("n", "<leader>sc", function()
	findFileArgsSubmited = false
end, { desc = "[s]earch [c]ustom" })

vim.keymap.set("n", "<leader>sc<cr>", function()
	findFileArgsSubmited = true
end, { desc = "submit" })

local findCustomKeys = "<leader>sc"
---@param arg findFilesArgs
local function executeFindFileArg(arg)
	-- local triggerKeys = vim.api.nvim_replace_termcodes(findCustomKeys, false, false, true)
	-- vim.api.nvim_feedkeys(vim.keycode(triggerKeys), "n", false)
	-- vim.fn.feedkeys(vim.keycode(triggerKeys), "n")
	findFilesOpts[arg.field] = arg.value
	vim.defer_fn(function()
		vim.fn.feedkeys(vim.keycode(findCustomKeys), "m")
	end, 100)
end

for _, arg in ipairs(findFilesDefaults) do
	-- vim.keymap.set("n", "<leader>sc" .. arg.key, "<leader>sc")

	-- vim.keymap.set("n", "<leader>sc" .. arg.key, function()
	-- 	executeFindFileArg(arg)
	-- end, { desc = arg.field .. ": " .. tostring(arg.value) })
	vim.keymap.set("n", "<leader>sc" .. arg.key, "<leader>sc", {
		desc = arg.field .. ": " .. tostring(arg.value),
		callback = function()
			require("which-key").add()
		end,
	})
end

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
