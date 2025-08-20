return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		command = "Telescope",
		keys = {
		    {
		        "<leader>ff",
		        require("telescope.builtin").find_files,
		        mode = "n",
		        desc = "Pick files",
		    },
		    {
		        "<leader>fb",
		        require("telescope.builtin").buffers,
		        mode = "n",
		        desc = "Pick buffers",
		    },
		    {
		        "<leader>fr",
		        require("telescope.builtin").resume,
		        mode = "n",
		        desc = "Resume picker",
		    },
		    {
		        "<leader>fk",
		        require("telescope.builtin").keymaps,
		        mode = "n",
		        desc = "Pick keymaps",
		    },
		    {
		        "<leader>fl",
		        require("telescope.builtin").current_buffer_fuzzy_find,
		        mode = "n",
		        desc = "Find lines",
		    },
		    {
		        "<leader>fs",
		        require("telescope.builtin").lsp_workspace_symbols,
		        mode = "n",
		        desc = "Pick lsp symbols",
		    },
		},
	},
}
