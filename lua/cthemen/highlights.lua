local M = {}

local function hl(name, opts)
  vim.api.nvim_set_hl(0, name, opts)
end

function M.setup(c)
  hl("Normal", { fg = c.fg, bg = c.bg })
  hl("NormalFloat", { fg = c.fg, bg = c.sidebar_bg })
  hl("NormalNC", { fg = c.fg, bg = c.bg })

  hl("ColorColumn", { bg = c.line_bg })
  hl("Conceal", { fg = c.whitespace })
  hl("Cursor", { fg = c.bg, bg = c.cursor })
  hl("CursorIM", { fg = c.bg, bg = c.cursor })
  hl("CursorColumn", { bg = c.line_bg })
  hl("CursorLine", { bg = c.line_bg })
  hl("CursorLineNr", { fg = c.active_line_nr, bold = true })

  hl("Directory", { fg = c.tag })

  hl("EndOfBuffer", { fg = c.bg })

  hl("ErrorMsg", { fg = c.error, bold = true })

  hl("WinSeparator", { fg = c.panel_border, bg = c.bg })
  hl("VertSplit", { fg = c.panel_border, bg = c.bg })

  hl("Folded", { fg = c.line_nr, bg = c.line_bg })
  hl("FoldColumn", { fg = c.line_nr, bg = c.bg })

  hl("SignColumn", { bg = c.bg })
  hl("SignColumnSB", { bg = c.sidebar_bg })

  hl("IncSearch", { bg = c.search_current, fg = c.fg })
  hl("Search", { bg = c.search, fg = c.fg })
  hl("Substitute", { bg = c.search_current, fg = c.fg })

  hl("LineNr", { fg = c.line_nr, bg = c.bg })

  hl("MatchParen", { fg = c.active_line_nr, bold = true, underline = true })

  hl("ModeMsg", { fg = c.fg, bold = true })
  hl("MoreMsg", { fg = c.tag, bold = true })

  hl("NonText", { fg = c.whitespace })
  hl("Whitespace", { fg = c.whitespace })
  hl("SpecialKey", { fg = c.whitespace })

  hl("Pmenu", { fg = c.dropdown_fg, bg = c.dropdown_bg })
  hl("PmenuSel", { bg = c.list_active, fg = c.dropdown_fg })
  hl("PmenuSbar", { bg = c.list_inactive })
  hl("PmenuThumb", { bg = c.scrollbar })

  hl("Question", { fg = c.tag })
  hl("QuickFixLine", { bg = c.selection })

  hl("StatusLine", { fg = c.statusline_fg, bg = c.statusline_bg })
  hl("StatusLineNC", { fg = c.tab_inactive_fg, bg = c.tab_inactive_bg })
  hl("StatusLineTerm", { fg = c.statusline_fg, bg = c.statusline_bg })
  hl("StatusLineTermNC", { fg = c.tab_inactive_fg, bg = c.tab_inactive_bg })

  hl("TabLine", { fg = c.tab_inactive_fg, bg = c.tab_inactive_bg })
  hl("TabLineFill", { bg = c.tab_bar_bg })
  hl("TabLineSel", { fg = c.tab_active_fg, bg = c.tab_active_bg })

  hl("Title", { fg = c.tag, bold = true })

  hl("Visual", { bg = c.selection })
  hl("VisualNOS", { bg = c.selection })

  hl("WarningMsg", { fg = c.warn })
  hl("WildMenu", { bg = c.list_active, fg = c.dropdown_fg })

  hl("WinBar", { fg = c.fg, bg = c.tab_bar_bg })
  hl("WinBarNC", { fg = c.tab_inactive_fg, bg = c.tab_bar_bg })

  hl("CursorWordSel", { bg = c.selection })

  hl("LspReferenceText", { bg = c.selection })
  hl("LspReferenceRead", { bg = c.selection })
  hl("LspReferenceWrite", { bg = c.selection })
  hl("LspSignatureActiveParameter", { bold = true, underline = true })

  hl("DiagnosticError", { fg = c.error })
  hl("DiagnosticWarn", { fg = c.warn })
  hl("DiagnosticInfo", { fg = c.info })
  hl("DiagnosticHint", { fg = c.hint })
  hl("DiagnosticOk", { fg = c.number })

  hl("DiagnosticUnderlineError", { sp = c.error, undercurl = true })
  hl("DiagnosticUnderlineWarn", { sp = c.warn, undercurl = true })
  hl("DiagnosticUnderlineInfo", { sp = c.info, undercurl = true })
  hl("DiagnosticUnderlineHint", { sp = c.hint, undercurl = true })
  hl("DiagnosticUnderlineOk", { sp = c.number, undercurl = true })

  hl("DiagnosticSignError", { fg = c.error, bg = c.bg })
  hl("DiagnosticSignWarn", { fg = c.warn, bg = c.bg })
  hl("DiagnosticSignInfo", { fg = c.info, bg = c.bg })
  hl("DiagnosticSignHint", { fg = c.hint, bg = c.bg })
  hl("DiagnosticSignOk", { fg = c.number, bg = c.bg })

  hl("DiagnosticVirtualTextError", { fg = c.error, bg = c.line_bg })
  hl("DiagnosticVirtualTextWarn", { fg = c.warn, bg = c.line_bg })
  hl("DiagnosticVirtualTextInfo", { fg = c.info, bg = c.line_bg })
  hl("DiagnosticVirtualTextHint", { fg = c.hint, bg = c.line_bg })
  hl("DiagnosticVirtualTextOk", { fg = c.number, bg = c.line_bg })

  hl("DiagnosticFloatingError", { fg = c.error })
  hl("DiagnosticFloatingWarn", { fg = c.warn })
  hl("DiagnosticFloatingInfo", { fg = c.info })
  hl("DiagnosticFloatingHint", { fg = c.hint })
  hl("DiagnosticFloatingOk", { fg = c.number })

  hl("DiffAdd", { bg = c.diff_add })
  hl("DiffChange", { bg = c.diff_line })
  hl("DiffDelete", { bg = c.diff_delete })
  hl("DiffText", { bg = c.selection })

  hl("diffAdded", { fg = c.number })
  hl("diffRemoved", { fg = c.regex })
  hl("diffChanged", { fg = c.warn })
  hl("diffFile", { fg = c.tag })
  hl("diffNewFile", { fg = c.number })
  hl("diffLine", { fg = c.function_fg })
  hl("diffIndexLine", { fg = c.comment })
end

return M
