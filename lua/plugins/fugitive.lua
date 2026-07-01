return {
  {
    "tpope/vim-fugitive",
    cmd = { "G", "Gvdiffsplit", "Gw" },
    dependencies = {
        "barrettruth/diffs.nvim"
    }
  },
}
