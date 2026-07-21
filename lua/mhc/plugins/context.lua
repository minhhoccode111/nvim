return {
  'nvim-treesitter/nvim-treesitter-context',
  config = function()
    require('treesitter-context').setup {
      enable = true,
      max_lines = 2,
    }

    local map = vim.keymap.set

    map('n', '<leader>tc', '<cmd> TSContextToggle <cr>', { desc = '[T]oggle [C]ontext Treesitter' })

    map({ 'n', 'v', 'o' }, '<leader>c', function()
      require('treesitter-context').go_to_context(vim.v.count1)
    end, { desc = 'Jump to [C]ontext above', silent = true })
  end,
}
