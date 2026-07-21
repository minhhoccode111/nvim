return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {},
  init = function()
    local map = vim.keymap.set
    map('n', '<leader>xp', '<cmd>lua require("bufferline").close_with_pick()<cr>', { desc = '[X]Close [P]ick Buffer' })
    map('n', '<leader>xo', '<cmd> BufferLineCloseOthers <cr>', { desc = '[X]Close [O]ther Buffers', silent = true })
    map('n', '<leader>xl', '<cmd> BufferLineCloseLeft <cr>', { desc = '[X]Close All Buffers to the [L]eft', silent = true })
    map('n', '<leader>xr', '<cmd> BufferLineCloseRight <cr>', { desc = '[X]Close All Buffers to the [R]ight', silent = true })
  end,
}
