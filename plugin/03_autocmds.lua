local autooscgrp = vim.api.nvim_create_augroup("autoosc", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
		if os.getenv("SSH_CONNECTION") then
			local copy_to_unnamedplus = require("vim.ui.clipboard.osc52").copy("+")
			copy_to_unnamedplus(vim.v.event.regcontents)
			local copy_to_unnamed = require("vim.ui.clipboard.osc52").copy("*")
			copy_to_unnamed(vim.v.event.regcontents)
		end
	end,
	group = autooscgrp,
})
