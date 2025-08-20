local dirdiffloaded = false
local function load_dirdiff()
	if not dirdiffloaded then
		vim.pack.add({
			{ src = "https://github.com/will133/vim-dirdiff" },
		}, { load = true })
		dirdiffloaded = true
	end
end

vim.api.nvim_create_user_command("DirDiff", function()
	load_dirdiff()
end, { desc = "Load dirdiff plugin" })
