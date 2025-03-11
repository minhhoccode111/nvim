-- codeium client for neovim

return {
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('codeium').setup {
      enable_cmp_source = true,
      virtual_text = {
        enable = true,
      },
    }

    local map = vim.keymap.set
    map('n', '<leader>Cc', '<cmd>Codeium Chat<cr>', { desc = '[C]hat [C]odeium' })
  end,
}
