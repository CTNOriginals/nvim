-- Move line Up/Down
vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

-- Copy line Up/Down
vim.keymap.set("n", "<CM-j>", "m`Vyp``j")
vim.keymap.set("n", "<CM-k>", "m`Vyp``")
vim.keymap.set("v", "<CM-j>", "Vykp'<v'>")
vim.keymap.set("v", "<CM-k>", "Vykpv'<k")

-- cycle tabs
vim.keymap.set("n", "<M-h>", "gT")
vim.keymap.set("n", "<M-l>", "gt")
vim.keymap.set("i", "<M-h>", "<Esc><Esc>gTa")
vim.keymap.set("i", "<M-l>", "<Esc><Esc>gta")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n>gTa")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n>gta")

-- move tab
vim.keymap.set("n", "<MC-h>", ":tabmove -1<CR>")
vim.keymap.set("n", "<MC-l>", ":tabmove +1<CR>")

-- Select word boundry
vim.keymap.set("n", "<leader>v", "bve", { desc = "[V]issually select word" })
vim.keymap.set("v", "<leader>", "vbve", { desc = "Select word" })
vim.keymap.set("i", "<C-e>", "<Esc>bvei", { desc = "Select word" })

-- Scroll viewport with cursor inplace
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- New Tab
vim.keymap.set("n", "<C-w>t", ":tabe<CR>", { desc = "Create new tab" })

-- Register managing
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Store the content of a yank in the system clipboard",
	group = vim.api.nvim_create_augroup("yank-to-clipboard", { clear = true }),
	callback = function()
		vim.cmd("let @+=@0")
	end,
})
