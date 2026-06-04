local c = require("cthemen.palette")

require("cthemen.highlights").setup(c)
require("cthemen.syntax").setup(c)
require("cthemen.treesitter").setup(c)
require("cthemen.plugins").setup(c)

vim.g.colors_name = "cthemen"
