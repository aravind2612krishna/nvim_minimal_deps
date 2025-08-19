-- ~/.config/nvim-new/plugin/plugins.lua
local function call_mason()
	vim.pack.add({
		{ src = "https://github.com/mason-org/mason.nvim" },
	})
	require("mason").setup({})
	vim.cmd("Mason")
end

-- local function setup_lsp_keymaps()
-- end

local function setup_lsp()
	vim.pack.add({
		{ src = "https://github.com/neovim/nvim-lspconfig" },
	})
	local ft = vim.bo.filetype
	if ft == "bash" or ft == "sh" then
		vim.lsp.enable("bashls")
	elseif ft == "c" or ft == "cpp" then
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
		vim.lsp.enable("clangd")
	elseif ft == "python" then
	    vim.lsp.enable("basedpyright")
	end
end

vim.api.nvim_create_user_command("Mason", call_mason, { desc = "Package manager for lsps" })
vim.api.nvim_create_user_command("LspEnable", setup_lsp, { desc = "Enable Lsp for current filetype" })
