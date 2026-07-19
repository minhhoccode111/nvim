return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<C-y>',
        clear_suggestion = '<C-;>',
        accept_word = '<C-j>',
      },
    }

    local map = vim.keymap.set
    map('n', '<leader>ts', '<cmd>SupermavenToggle<CR>', { desc = '[T]oggle [S]upermaven' })
  end,
}
