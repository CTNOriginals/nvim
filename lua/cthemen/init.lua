vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/cthemen")
vim.opt.rtp:append(vim.fn.stdpath("config") .. "/lua/cthemen/overrides")

local c = require("cthemen.palette")

require("cthemen.highlights").setup(c)
require("cthemen.syntax").setup(c)
require("cthemen.treesitter").setup(c)
require("cthemen.plugins").setup(c)
require("cthemen.overrides").setup()

vim.g.colors_name = "cthemen"
