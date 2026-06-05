local function hpcall(class, fn)
	return ":lua require('harpoon." .. class .. "')." .. fn .. "()<CR>"
end

vim.keymap.set("n", "<leader>h", "", {
	desc = "[H]arpoon",
})
vim.keymap.set("n", "<leader>hm", hpcall("ui", "toggle_quick_menu"), {
	desc = "[H]arpoon [M]enu",
})
vim.keymap.set("n", "<leader>ha", hpcall("mark", "add_file"), {
	desc = "[H]arpoon [A]dd",
})

vim.keymap.set("n", "<M-o>", hpcall("ui", "nav_next"), {
	desc = "Harpoon Next",
})
vim.keymap.set("n", "<M-i>", hpcall("ui", "nav_prev"), {
	desc = "Harpoon Previous",
})

return {
	"ThePrimeagen/harpoon",
	opts = {
		tabline = false,
	},
}
