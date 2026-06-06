vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<M-h>", "gT")
vim.keymap.set("n", "<M-l>", "gt")
vim.keymap.set("i", "<M-h>", "<Esc><Esc>gTa")
vim.keymap.set("i", "<M-l>", "<Esc><Esc>gta")
vim.keymap.set("t", "<M-h>", "<C-\\><C-n>gTa")
vim.keymap.set("t", "<M-l>", "<C-\\><C-n>gta")
vim.keymap.set("n", "<MC-h>", ":tabmove -1<CR>")
vim.keymap.set("n", "<MC-l>", ":tabmove +1<CR>")

vim.keymap.set("n", "<C-W>Q", "<C-W>o<C-W>q", { desc = "Close tab" })
vim.keymap.set("n", "<C-w>t", ":tabe<CR>", { desc = "Create new tab" })

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
