vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<M-h>", "gT", { desc = "Previous tab" })
vim.keymap.set("n", "<M-l>", "gt", { desc = "Next tab" })
vim.keymap.set("i", "<M-h>", "<Esc><Esc>gTa", { desc = "Previous tab" })
vim.keymap.set("i", "<M-l>", "<Esc><Esc>gta", { desc = "Next tab" })
vim.keymap.set("t", "<M-h>", "<C-\\><C-n>gTa", { desc = "Previous tab" })
vim.keymap.set("t", "<M-l>", "<C-\\><C-n>gta", { desc = "Next tab" })
vim.keymap.set("n", "<MC-h>", ":tabmove -1<CR>", { desc = "Move tab left" })
vim.keymap.set("n", "<MC-l>", ":tabmove +1<CR>", { desc = "Move tab right" })

vim.keymap.set("n", "<C-W>Q", "<C-W>o<C-W>q", { desc = "Close tab" })
vim.keymap.set("n", "<C-w>t", ":tabe<CR>", { desc = "Create new tab" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down, cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up, cursor centered" })
