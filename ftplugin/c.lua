if not vim.wo.scrollbind then
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldnestmax = 10
    vim.opt_local.foldlevelstart = 99
end

local func_nav = require("utils.func_nav")
vim.keymap.set("n", "]m", function() func_nav.goto_function_definition(1) end,
    { buffer = true, desc = "Next function_definition" })
vim.keymap.set("n", "[m", function() func_nav.goto_function_definition(-1) end,
    { buffer = true, desc = "Previous function_definition" })
