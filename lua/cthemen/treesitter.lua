local M = {}

local function hl(name, opts)
	vim.api.nvim_set_hl(0, name, opts)
end

function M.setup(c)
	hl("@comment", { fg = c.comment })
	hl("@comment.error", { fg = c.error, bold = true })
	hl("@comment.warning", { fg = c.warn })
	hl("@comment.todo", { fg = c.todo, bold = true })
	hl("@comment.note", { fg = c.info })

	hl("@constant", { fg = c.constant })
	hl("@constant.builtin", { fg = c.builtin })
	hl("@constant.macro", { fg = c.preproc })

	hl("@constructor", { fg = c.constructor })

	hl("@function", { fg = c.function_fg })
	hl("@function.builtin", { fg = c.builtin })
	hl("@function.call", { fg = c.function_fg })
	hl("@function.macro", { fg = c.decorator })
	hl("@function.method", { fg = c.function_fg })
	hl("@function.method.call", { fg = c.function_fg })

	hl("@keyword", { fg = c.keyword, bold = true })
	hl("@keyword.function", { fg = c.keyword_declaration, bold = true })
	hl("@keyword.operator", { fg = c.keyword, bold = true })
	hl("@keyword.return", { fg = c.keyword_flow, bold = true })

	hl("@label", { fg = c.label, bold = true })

	hl("@method", { fg = c.function_fg })
	hl("@method.call", { fg = c.function_fg })

	hl("@namespace", { fg = c.namespace })

	hl("@number", { fg = c.number })
	hl("@number.float", { fg = c.number })
	hl("@boolean", { fg = c.boolean })

	hl("@operator", { fg = c.operator, bold = true })

	hl("@parameter", { fg = c.parameter })
	hl("@parameter.reference", { fg = c.parameter })
	hl("@go.receiver", { fg = c.receiver })

	hl("@property", { fg = c.property })

	hl("@punctuation.delimiter", { fg = c.delimiter })
	hl("@punctuation.bracket", { fg = c.bracket })
	hl("@punctuation.special", { fg = c.escape })

	hl("@string", { fg = c.string })
	hl("@string.documentation", { fg = c.string })
	hl("@string.escape", { fg = c.escape })
	hl("@string.regex", { fg = c.regex })
	hl("@string.special", { fg = c.escape })
	hl("@string.special.symbol", { fg = c.constant })
	hl("@string.special.url", { fg = c.uri, underline = true })

	hl("@character", { fg = c.string })
	hl("@character.special", { fg = c.escape })

	hl("@tag", { fg = c.tag })
	hl("@tag.attribute", { fg = c.property })
	hl("@tag.delimiter", { fg = c.delimiter })

	hl("@type", { fg = c.type })
	hl("@type.builtin", { fg = c.builtin, bold = true })
	hl("@type.definition", { fg = c.type })
	hl("@type.qualifier", { fg = c.keyword })

	hl("@variable", { fg = c.variable })
	hl("@variable.builtin", { fg = c.builtin })
	hl("@variable.member", { fg = c.member })
	hl("@variable.parameter", { fg = c.parameter })

	hl("@field", { fg = c.member })
	hl("@float", { fg = c.number })

	hl("@symbol", { fg = c.constant })

	hl("@attribute", { fg = c.property })
	hl("@attribute.builtin", { fg = c.builtin })

	hl("@interface", { fg = c.type })
	hl("@module", { fg = c.namespace })
	hl("@module.qualifier", { fg = c.module })

	hl("@none", {})
	hl("@error", { fg = c.error })
	hl("@exception", { fg = c.keyword_flow, bold = true })
	hl("@include", { fg = c.preproc })
	hl("@conditional", { fg = c.keyword_flow, bold = true })
	hl("@repeat", { fg = c.keyword_flow, bold = true })
	hl("@define", { fg = c.preproc })
	hl("@storageclass", { fg = c.keyword_declaration, bold = true })
	hl("@preproc", { fg = c.preproc })
	hl("@debug", { fg = c.special })

	hl("@markup.heading", { fg = c.markdown_heading, bold = true })
	hl("@markup.heading.1", { fg = c.markdown_heading, bold = true })
	hl("@markup.heading.2", { fg = c.markdown_heading, bold = true })
	hl("@markup.heading.3", { fg = c.markdown_heading, bold = true })
	hl("@markup.heading.4", { fg = c.markdown_heading, bold = true })
	hl("@markup.heading.5", { fg = c.markdown_heading, bold = true })
	hl("@markup.heading.6", { fg = c.markdown_heading, bold = true })
	hl("@markup.raw", { fg = c.markdown_code })
	hl("@markup.raw.block", { fg = c.markdown_code })
	hl("@markup.list", { fg = c.markdown_list })
	hl("@markup.list.checked", { fg = c.number })
	hl("@markup.list.unchecked", { fg = c.delimiter })
	hl("@markup.quote", { fg = c.markdown_quote })
	hl("@markup.link", { fg = c.uri, underline = true })
	hl("@markup.link.url", { fg = c.uri, underline = true })
	hl("@markup.link.label", { fg = c.tag })
	hl("@markup.strong", { bold = true })
	hl("@markup.italic", { italic = true })
	hl("@markup.strikethrough", { strikethrough = true })
	hl("@markup.underline", { underline = true })
	hl("@markup.math", { fg = c.number })

	hl("@diff.plus", { fg = c.number })
	hl("@diff.minus", { fg = c.regex })
	hl("@diff.delta", { fg = c.warn })

	hl("@keyword.import", { fg = c.preproc, bold = true })
	hl("@keyword.storage", { fg = c.keyword_declaration, bold = true })
	hl("@keyword.repeat", { fg = c.keyword_flow, bold = true })
	hl("@keyword.debug", { fg = c.special })
	hl("@keyword.directive", { fg = c.preproc })
	hl("@keyword.directive.define", { fg = c.preproc })
	hl("@keyword.conditional", { fg = c.keyword_flow, bold = true })
	hl("@keyword.exception", { fg = c.keyword_flow, bold = true })
	hl("@keyword.coroutine", { fg = c.keyword_flow, bold = true })
	hl("@keyword.type", { fg = c.keyword_declaration, bold = true })
	hl("@keyword.modifier", { fg = c.keyword_type, bold = true })

	hl("@lsp.type.keyword", { fg = c.none })
	hl("@lsp.type.type", { fg = c.type })
	hl("@lsp.type.class", { fg = c.type })
	hl("@lsp.type.enum", { fg = c.type })
	hl("@lsp.type.interface", { fg = c.type })
	hl("@lsp.type.namespace", { fg = c.namespace })
	hl("@lsp.type.namespace.go", { fg = c.module })
	hl("@lsp.type.parameter", { fg = c.parameter })
	hl("@lsp.type.variable", { fg = c.variable })
	hl("@lsp.type.constant", { fg = c.constant })
	hl("@lsp.typemod.variable.readonly", { fg = c.constant })
	hl("@lsp.typemod.variable.constant", { fg = c.constant })
	hl("@lsp.typemod.variable.defaultLibrary", { fg = c.builtin })
	hl("@lsp.typemod.variable.global", { fg = c.constant })
	hl("@lsp.typemod.variable.static", { fg = c.constant })
	hl("@lsp.type.property", { fg = c.property })
	hl("@lsp.type.function", { fg = c.function_fg })
	hl("@lsp.type.method", { fg = c.function_fg })
	hl("@lsp.type.macro", { fg = c.decorator })
	hl("@lsp.type.struct", { fg = c.type })
	hl("@lsp.type.selfKeyword", { fg = c.keyword })
	hl("@lsp.type.selfTypeKeyword", { fg = c.type })
end

return M
