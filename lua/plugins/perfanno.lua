return {
  "t-troebst/perfanno.nvim",
  opts = {},
  cmd = {"PerfLoadCallGraph", "PerfLuaProfileStart"},
  config = function(_, opts)
      require("perfanno").setup(opts)
  end
}
