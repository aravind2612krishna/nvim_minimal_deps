-- gitlinker
local gitlinkerloaded = false
local function load_gitlinker()
	if not gitlinkerloaded then
		vim.pack.add({
			{ src = "https://github.com/linrongbin16/gitlinker.nvim" },
		}, { load = true })
		require("gitlinker").setup()
		gitlinkerloaded = true
	end
end

vim.api.nvim_create_user_command("LoadGitlinker", load_gitlinker, { desc = "Load gitlinker.nvim plugin" })
vim.keymap.set({ "n", "v" }, "<leader>gy", function()
	load_gitlinker()
	vim.cmd("GitLink")
end, { silent = true, noremap = true, desc = "Yank git permlink" })
vim.keymap.set({ "n", "v" }, "<leader>go", function()
	load_gitlinker()
	vim.cmd("GitLink!")
end, { silent = true, noremap = true, desc = "Open git permlink" })

-- aravk_nvim_utils
local aravkutilsloaded = false
local function load_aravkutils()
	if not aravkutilsloaded then
	    load_gitlinker()
		vim.pack.add({
			{ src = "https://github.com/aravind2612krishna/aravk_nvim_utils" },
		}, { load = true })
		aravkutilsloaded = true
		require("aravk_nvim_utils.smartcodecopy").setup({})
	end
end
vim.keymap.set("n", "<Leader>td", function()
	if not aravkutilsloaded then
		load_aravkutils()
		local termdebug = require("aravk_nvim_utils.termdebug")
		if termdebug then
			termdebug.setupdbg()
		end
	else
		vim.cmd("Termdebug")
	end
end, { silent = true, noremap = true, desc = "Setup termdebug and start it" })
vim.keymap.set({ "n", "x" }, "<Leader>cc", function()
	load_aravkutils()
	vim.cmd("CopyContext")
end, { silent = true, noremap = true, desc = "Smart code copy" })
