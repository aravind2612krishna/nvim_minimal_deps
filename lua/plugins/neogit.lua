return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration
	},
	command = "Neogit",
	opts = {
		sections = {
			-- Reverting/Cherry Picking
			sequencer = {
				folded = false,
				hidden = false,
			},
			unstaged = {
				folded = false,
				hidden = false,
			},
			staged = {
				folded = false,
				hidden = false,
			},
			untracked = {
				folded = true,
				hidden = false,
			},
		},
		graph_style = "kitty",
	},
	config = function(_, opts)
		require("neogit").setup(opts)
	end,
}
