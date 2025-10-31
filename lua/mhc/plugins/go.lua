return {
  'maxandron/goplements.nvim',
  ft = 'go',
  opts = {},
  config = function(_, opts)
    local goplements = require 'goplements'
    goplements.setup(opts)

    vim.keymap.set('n', '<leader>g', goplements.toggle, { desc = 'Goplements [T]oggle interface/struct implements' })
  end,
}
