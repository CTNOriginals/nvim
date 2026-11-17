return {
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			-- Skip projects with their own .luarc.json (e.g. Factorio mods), since
			-- lazydev's injected settings (ignoreDir "/lua", LuaJIT runtime) break them
			enabled = function(root_dir)
				return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
			end,
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "/usr/share/hypr/stubs", words = { "hl%." } },
			},
		},
	},

	{ "neovim/nvim-lspconfig",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
			"saghen/blink.cmp",
		},
		config = function()
			-- Runtime version is left to lazydev (nvim config) or .luarc.json (e.g. Factorio mods)
			local servers = {
				gopls = {},
				ts_ls = {},
				lua_ls = {
					settings = {
						Lua = {
							completion = { callSnippet = "Replace" },
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, { "stylua" })
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })
			for name, server in pairs(servers) do
				vim.lsp.config(name, server)
			end

			-- mason-lspconfig v2 calls vim.lsp.enable() for installed servers
			require("mason-lspconfig").setup({ ensure_installed = {} })
		end,
	},
}
