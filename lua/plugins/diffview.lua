return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewFileHistory" },
	opts = {
		view = {
			-- Configure the layout and behavior of different types of views.
			merge_tool = {
				-- Config for conflicted files in diff views during a merge or rebase.
				-- layout = "diff4_mixed",
				disable_diagnostics = true, -- Temporarily disable diagnostics for diff buffers while in the view.
				winbar_info = true, -- See |diffview-config-view.x.winbar_info|
			},
		},
	},
}
