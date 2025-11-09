-- improve default vim.ui interfaces

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    -- indent = { enabled = true },
    quickfile = { enabled = true },
    image = {
      enabled = true,
      doc = {
        enabled = true,
        inline = false,
        float = false,
        max_width = 10,
        max_height = 10,
      },
    },
  },
  keys = {
    {
      '<leader>i',
      function()
        require('snacks').image.hover()
      end,
      desc = '[I]mage Preview',
    },
  },
}
