return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup {} -- use default

      local map = vim.keymap.set

      map('n', '<leader>fF', function()
        require('telescope').extensions.flutter.commands()
      end, { desc = '[F]ind [F]lutter Command to Run' })

      map('n', '<leader>;', function()
        require('telescope').extensions.flutter.commands()
      end, { desc = '[F]ind [F]lutter Command to Run' })
    end,
  },
}
