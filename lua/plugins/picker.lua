return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		keys = {
		    {
		        "<leader>ff",
		        function() require("telescope.builtin").find_files() end,
		        mode = "n",
		        desc = "Pick files",
		    },
		    {
		        "<leader>fb",
		        function() require("telescope.builtin").buffers()  end,
		        mode = "n",
		        desc = "Pick buffers",
		    },
		    {
		        "<leader>fr",
		        function() require("telescope.builtin").resume() end,
		        mode = "n",
		        desc = "Resume picker",
		    },
		    {
		        "<leader>fk",
		        function() require("telescope.builtin").keymaps() end,
		        mode = "n",
		        desc = "Pick keymaps",
		    },
		    {
		        "<leader>fl",
		        function() require("telescope.builtin").current_buffer_fuzzy_find() end,
		        mode = "n",
		        desc = "Find lines",
		    },
		    {
		        "<leader>fs",
		        function() require("telescope.builtin").lsp_workspace_symbols() end,
		        mode = "n",
		        desc = "Pick lsp symbols",
		    },
		},
	},
}
