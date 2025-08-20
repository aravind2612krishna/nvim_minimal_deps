vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/tpope/vim-fugitive" },
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
}, { load = true })

require("gitsigns").setup({ signcolumn = true })
require("oil").setup({
	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},
	default_file_explorer = true,
})
require("blink.cmp").setup({
	keymap = {
		preset = "default",
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },
		["<CR>"] = {
			function(cmp)
				if cmp.get_selected_item_idx then
					return cmp.accept()
				end
			end,
			"fallback",
		},

		["<Tab>"] = {
			function(cmp)
				if (not cmp.is_visible()) and cmp.snippet_active() then
					return cmp.snippet_forward()
				else
					if cmp.is_visible() then
						return cmp.select_next()
					end
				end
			end,
			"fallback",
		},
		["<S-Tab>"] = {
			function(cmp)
				if (not cmp.is_visible()) and cmp.snippet_active() then
					return cmp.snippet_backward()
				else
					if cmp.is_visible() then
						return cmp.select_prev()
					end
				end
			end,
			"fallback",
		},
	},
	fuzzy = {
		sorts = { "score", "sort_text", "exact" },
		use_frecency = true,
		use_proximity = true,
		implementation = "prefer_rust",
	},
	completion = {
		list = {
			selection = {
				preselect = true,
				-- preselect = function(ctx)
				--   return ctx.mode ~= "cmdline" and not require("blink.cmp").snippet_active { direction = 1 }
				-- end,
			},
		},
		ghost_text = {
			enabled = true,
			-- Show the ghost text when an item has been selected
			-- show_with_selection = true,
			-- Show the ghost text when no item has been selected, defaulting to the first item
			-- show_without_selection = false,
			-- Show the ghost text when the menu is open
			show_with_menu = false,
			-- Show the ghost text when the menu is closed
			show_without_menu = true,
		},
	},
	cmdline = {
		enabled = false,
		keymap = { preset = "inherit" },
		completion = {
			menu = { auto_show = true },
			list = {
				selection = {
					preselect = false,
					auto_insert = true,
				},
			},
		},
	},
	sources = {
		default = { "lsp", "buffer", "path", "snippets" },
		providers = {
			lsp = {
				min_keyword_length = 0,
				score_offset = 3,
				async = true,
				fallbacks = {},
			},
			snippets = { score_offset = -3 },
		},
	},
	snippets = {
		score_offset = -10,
	},
})
