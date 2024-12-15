-- Add indentation guides even on blank lines

return {
  -- Enable `lukas-reineke/indent-blankline.nvim`
  -- See `:help ibl`
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    exclude = {
      -- greet screen
      filetypes = { 'dashboard' },
    },
  },
}
