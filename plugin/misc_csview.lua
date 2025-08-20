local csvviewloaded = false
local function load_csvview()
	if not csvviewloaded then
		vim.pack.add({
			{ src = "https://github.com/hat0uma/csvview.nvim" },
		}, { load = true })
		require("csvview").setup()
		csvviewloaded = true
	end
end

vim.api.nvim_create_user_command("LoadCsvView", function()
	load_csvview()
	vim.cmd("CsvViewToggle")
end, { desc = "Load csvview.nvim plugin" })
