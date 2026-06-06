vim.keymap.set("n", "<M-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<CM-j>", "m`Vyp``j")
vim.keymap.set("n", "<CM-k>", "m`Vyp``")
vim.keymap.set("v", "<CM-j>", "Vykp'<v'>")
vim.keymap.set("v", "<CM-k>", "Vykpv'<k")

vim.keymap.set("n", "<leader>v", "bve", { desc = "[V]issually select word" })
vim.keymap.set("v", "<leader>v", "vbve", { desc = "Select word" })
vim.keymap.set("i", "<C-e>", "<Esc>bvei", { desc = "Select word" })
