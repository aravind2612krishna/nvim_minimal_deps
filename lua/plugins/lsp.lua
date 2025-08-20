return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		local mason = require("mason")

		mason.setup()
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"-j=10",
				"--clang-tidy",
				"--enable-config",
				"--header-insertion=never",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--include-ineligible-results",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		})
	end,
}
