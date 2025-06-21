-- improve default vim.ui interfaces

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    indent = { enabled = true },
    quickfile = { enabled = true },
  },
}
