local flipploaded = false
local function load_flipp()
	if not flipploaded then
		vim.pack.add({
			{ src = "https://github.com/willtrojniak/flipp.nvim" },
		}, { load = true })
		require("flipp").setup()
		flipploaded = true
	end
end

vim.api.nvim_create_user_command("Flipp", function()
	load_flipp()
end, { desc = "Load gitlinker.nvim plugin" })
