local M = {}

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

function M.setup(c)
	hl("Comment", { fg = c.comment, italic = false })

	hl("Constant", { fg = c.constant })
	hl("String", { fg = c.string })
	hl("Character", { fg = c.string })
	hl("Number", { fg = c.number })
	hl("Boolean", { fg = c.boolean })
	hl("Float", { fg = c.number })

	hl("Identifier", { fg = c.variable })
	hl("Function", { fg = c.function_fg })

	hl("Statement", { fg = c.keyword, bold = true })
	hl("Conditional", { fg = c.keyword, bold = true })
	hl("Repeat", { fg = c.keyword, bold = true })
	hl("Label", { fg = c.label, bold = true })
	hl("Operator", { fg = c.operator })
	hl("Keyword", { fg = c.keyword, bold = true })
	hl("Exception", { fg = c.keyword, bold = true })

	hl("PreProc", { fg = c.preproc })
	hl("Include", { fg = c.preproc })
	hl("Define", { fg = c.preproc })
	hl("Macro", { fg = c.preproc })
	hl("PreCondit", { fg = c.preproc })

	hl("Type", { fg = c.type_fg })
	hl("StorageClass", { fg = c.keyword_declaration, bold = true })
	hl("Structure", { fg = c.type_fg })
	hl("Typedef", { fg = c.type_fg })

	hl("Special", { fg = c.special })
	hl("SpecialChar", { fg = c.escape })
	hl("Tag", { fg = c.tag })
	hl("Delimiter", { fg = c.delimiter })
	hl("SpecialComment", { fg = c.comment })
	hl("Debug", { fg = c.special })

	hl("Underlined", { fg = c.uri, underline = true })
	hl("Ignore", { fg = c.none })
	hl("Error", { fg = c.error, bold = true })
	hl("Todo", { fg = c.keyword, bold = true })

	hl("SpellBad", { sp = c.error, undercurl = true })
	hl("SpellCap", { sp = c.warn, undercurl = true })
	hl("SpellLocal", { sp = c.info, undercurl = true })
	hl("SpellRare", { sp = c.special, undercurl = true })
end

return M
