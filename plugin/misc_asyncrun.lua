-- asyncrun
local asyncrunloaded = false
local function load_asyncrun()
	if not asyncrunloaded then
		vim.pack.add({
			{ src = "https://github.com/skywind3000/asyncrun.vim" },
		}, { load = true })
		-- require("asyncrun").setup()
		asyncrunloaded = true
	end
end

vim.keymap.set("n", "<Leader>rr", function()
    load_asyncrun()
	local bufnr = vim.api.nvim_get_current_buf()
	local cmd = "AsyncRun rg --vimgrep -i " .. vim.fn.expand("<cword>") .. " " .. vim.fn.expand("%:.:h")
	vim.cmd(cmd)
	vim.fn.histadd("cmd", cmd)
	local currwinid = vim.fn.win_getid()
	vim.cmd([[ topleft copen ]]) -- open quickfix top left
	vim.fn.win_gotoid(currwinid) -- go back to previous window
end, { desc = "grep in relative dir" })
