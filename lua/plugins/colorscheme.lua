return {
	{
		"wuelnerdotexe/vim-enfocado",
        lazy=false,
        priority=1000,
		config = function(_, _)
			vim.o.termguicolors = true
			vim.o.background = "dark"
			vim.cmd.colorscheme("enfocado")
			vim.cmd([[hi! link MiniStatuslineFilename MoreMsg]])
			vim.cmd([[hi! link TabLineSel MoreMsg]])
			vim.cmd([[hi! link TabLine LspInlayHint]])
			vim.cmd([[hi! link TreesitterContextBottom Underlined]])
			vim.cmd([[hi! link VertSplit AccentSecond]])
		end,
	},
}
