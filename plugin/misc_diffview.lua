local diffviewloaded = false
local function load_diffview()
	if not diffviewloaded then
		vim.pack.add({
			{ src = "https://github.com/sindrets/diffview.nvim" },
		}, { load = true })
		require("diffview").setup()
		diffviewloaded = true
	end
end

vim.api.nvim_create_user_command("Diffview", function()
	load_diffview()
	vim.cmd("DiffviewOpen")
end, { desc = "Load diffview.nvim plugin" })
