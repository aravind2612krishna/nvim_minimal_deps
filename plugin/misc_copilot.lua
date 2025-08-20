-- copilot
local copilotloaded = false
local function load_copilot()
	if not copilotloaded then
		vim.pack.add({
			{ src = "https://github.com/zbirenbaum/copilot.lua" },
			{ src = "https://github.com/CopilotC-Nvim/CopilotChat.nvim" },
		}, { load = true })
		require("copilot").setup({
			panel = {
				enabled = true,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<M-CR>",
					refresh = "gr",
					open = "<C-CR>",
				},
				layout = {
					position = "bottom", -- | top | left | right
					ratio = 0.4,
				},
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				hide_during_completion = false,
				debounce = 75,
				keymap = {
					accept = "<M-CR>",
					accept_word = false,
					accept_line = false,
					next = "<M-]>",
					prev = "<M-[>",
					dismiss = "<C-]>",
				},
			},
		})
		copilotloaded = true
	end
	require("CopilotChat").setup()
end

vim.api.nvim_create_user_command("LoadCopilotChat", function()
	load_copilot()
	vim.cmd("CopilotChat")
end, { desc = "Load gitlinker.nvim plugin" })
