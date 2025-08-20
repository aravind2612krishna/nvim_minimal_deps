return {
	"jbyuki/one-small-step-for-vimkind",
	-- stylua: ignore
	keys = {
		{ "<Leader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
		{ "<Leader>dal", function() require("osv").run_this() end,              desc = "Adapter Lua" },
		{ "<Leader>das", function() require("osv").stop() end,              desc = "Adapter Lua" },
	},
	dependencies = { "mfussenegger/nvim-dap" },
	config = function()
		local dap = require("dap")
		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end
		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
				host = function()
					return "127.0.0.1"
				end,
				port = function()
					local val = tonumber(vim.fn.input("Port: ", "8086"))
					assert(val, "Please provide a port number")
					return val
				end,
			},
		}
	end,
}
