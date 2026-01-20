return {
    {
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
    },
    {
        "esmuellert/codediff.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        cmd = "CodeDiff",
    },
    {
        "jake-stewart/diff.nvim",
        cmd = "Diff",
        opts = {
            -- show a unified diff (single pane)
            unified = false,

            -- either "tab", "above", "below", "left", or "right"
            position = "below",

            -- show the cursorline within the diff windows
            cursorline = false
        }
    },
}
