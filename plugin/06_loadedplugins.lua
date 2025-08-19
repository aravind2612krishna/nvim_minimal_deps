vim.pack.add({
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
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
