vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [q]uickfix list" })

vim.keymap.set("n", "<leader>b", "", { desc = "[b]uffer" })
vim.keymap.set("n", "<leader>bD", function()
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if not vim.api.nvim_buf_is_loaded(bufnr) or #vim.fn.win_findbuf(bufnr) == 0 then
			vim.api.nvim_buf_delete(bufnr, { force = false })
		end
	end
end, { desc = "[b]uffer [D]elete unopened" })

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
