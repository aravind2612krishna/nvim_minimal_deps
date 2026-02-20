if not vim.wo.scrollbind then
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.opt_local.foldnestmax = 10
    vim.opt_local.foldlevelstart = 99
end
