vim.keymap.set("n", "<M-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<M-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<M-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<M-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

vim.keymap.set("n", "<CM-j>", "m`Vyp``j", { desc = "Duplicate line below" })
vim.keymap.set("n", "<CM-k>", "m`Vyp``", { desc = "Duplicate line above" })
vim.keymap.set("v", "<CM-j>", "Vykp'<v'>", { desc = "Duplicate selection below" })
vim.keymap.set("v", "<CM-k>", "Vykpv'<k", { desc = "Duplicate selection above" })

vim.keymap.set("n", "<leader>v", "bve", { desc = "[V]issually select word" })
vim.keymap.set("v", "<leader>v", "vbve", { desc = "Select word" })
vim.keymap.set("i", "<C-e>", "<Esc>bvei", { desc = "Select word" })
