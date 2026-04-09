-- source: https://github.com/nvim-telescope/telescope.nvim/issues/621#issuecomment-2094652982

local builtin = require("telescope.builtin")
local action_state = require("telescope.actions.state")

vim.keymap.set("n", "<C-e>", function()
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
end)
