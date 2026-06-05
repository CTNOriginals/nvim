return {
  "nvim-treesitter/nvim-treesitter-context",
  config = function() end,
  opts = {
    enable = true,
    multiwindow = true,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 4,
    trim_scope = "inner",
    mode = "cursor",
    separator = "-",
    zindex = 20,
    on_attach = nil,
  },
}
