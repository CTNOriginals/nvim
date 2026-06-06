vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<CM-j>", "m`Vyp``j")
vim.keymap.set("n", "<CM-k>", "m`Vyp``")
vim.keymap.set("v", "<CM-j>", "Vykp'<v'>")
vim.keymap.set("v", "<CM-k>", "Vykpv'<k")

vim.keymap.set("n", "<M-h>", "gT")
vim.keymap.set("n", "<M-l>", "gt")
vim.keymap.set("i", "<M-h>", "<Esc><Esc>gTa")
vim.keymap.set("i", "<M-l>", "<Esc><Esc>gta")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n>gTa")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n>gta")

vim.keymap.set("n", "<MC-h>", ":tabmove -1<CR>")
vim.keymap.set("n", "<MC-l>", ":tabmove +1<CR>")

vim.keymap.set("n", "<leader>v", "bve", { desc = "[V]issually select word" })
vim.keymap.set("v", "<leader>v", "vbve", { desc = "Select word" })
vim.keymap.set("i", "<C-e>", "<Esc>bvei", { desc = "Select word" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<C-w>t", ":tabe<CR>", { desc = "Create new tab" })

vim.keymap.set("n", "<C-e>", function()
	local builtin = require("telescope.builtin")
	local action_state = require("telescope.actions.state")

	builtin.buffers({
		initial_mode = "normal",
		attach_mappings = function(prompt_bufnr, map)
			local delete_buf = function()
				local current_picker = action_state.get_current_picker(prompt_bufnr)
				current_picker:delete_selection(function(selection)
					vim.api.nvim_buf_delete(selection.bufnr, { force = true })
				end)
			end

			map("n", "<c-d>", delete_buf)
			return true
		end,
	}, {
		sort_lastused = true,
		sort_mru = true,
		theme = "dropdown",
	})
end, { desc = "List buffers (d to delete)" })

vim.keymap.set("n", "<leader>h", "", { desc = "[H]arpoon" })
vim.keymap.set("n", "<leader>hm", function()
	require("harpoon.ui").toggle_quick_menu()
end, { desc = "[H]arpoon [M]enu" })
vim.keymap.set("n", "<leader>ha", function()
	require("harpoon.mark").add_file()
end, { desc = "[H]arpoon [A]dd" })

vim.keymap.set("n", "<M-o>", function()
	require("harpoon.ui").nav_next()
end, { desc = "Harpoon Next" })
vim.keymap.set("n", "<M-i>", function()
	require("harpoon.ui").nav_prev()
end, { desc = "Harpoon Previous" })

vim.keymap.set("n", "<leader>ts", "", { desc = "[T]ree[S]itter" })
vim.keymap.set("n", "<leader>tsi", "<cmd>Inspect<cr>", { desc = "[T]ree[S]itter [I]nspect" })
vim.keymap.set("n", "<leader>tst", "<cmd>InspectTree<cr>", { desc = "[T]ree[S]itter Inspect [T]ree" })

