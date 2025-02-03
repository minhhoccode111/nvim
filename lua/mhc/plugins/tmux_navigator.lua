-- navigate tmux the same as in neovim using <C-hjkl>

return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  init = function()
    local map = vim.keymap.set
    -- tmux navigator to also work with tmux instead of default only in neovim
    map('n', '<c-h>', '<cmd> TmuxNavigateLeft <cr>', { desc = 'Move focus to the left window' })
    map('n', '<c-l>', '<cmd> TmuxNavigateRight <cr>', { desc = 'Move focus to the right window' })
    map('n', '<c-j>', '<cmd> TmuxNavigateDown <cr>', { desc = 'Move focus to the lower window' })
    map('n', '<c-k>', '<cmd> TmuxNavigateUp <cr>', { desc = 'Move focus to the upper window' })
  end,
}
