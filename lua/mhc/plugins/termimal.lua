return {
  {
    'NvChad/nvterm',
    config = function()
      require('nvterm').setup {
        -- Default setting
        terminals = {
          --   shell = vim.o.shell,
          --   list = {},
          type_opts = {
            float = {
              --       relative = 'editor',
              row = 0.1, -- row * 2 + height = 1 to be centered
              col = 0.2, -- col * 2 + width = 1 to be centered
              width = 0.6,
              height = 0.8,
              --       border = 'single',
            },
            horizontal = { location = 'rightbelow', split_ratio = 0.35 },
            vertical = { location = 'rightbelow', split_ratio = 0.35 },
          },
        },
        behavior = {
          autoclose_on_quit = {
            -- This free a port when terminal close and prevent us from crash memory
            enabled = true,
            confirm = false,
          },
          -- close_on_exit = true,
          -- this also make the buffer terminal auto focus
          -- not cool when we navigate between buffers with <C-i> and <C-o>
          auto_insert = false,
        },
      }

      local map = vim.keymap.set

      -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
      -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
      -- is not what someone will guess without a bit more experience.
      -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
      -- or just use <C-\><C-n> to exit terminal mode
      map('t', 'jj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

      -- Open terminals -- In new buffer to will be displayed like tab on bufferline to quick navigate
      map('n', '<leader>tt', '<cmd> ter <cr>', { desc = 'New [T]erminal Buffer' })

      -- Togglable fast, 'i' since it's closest
      map({ 'n', 't' }, '<a-i>', '<cmd>lua require("nvterm.terminal").toggle "float"<cr>', { desc = '[T]erminal [F]loat' })

      -- map({ 'n', 't' }, '<a-h>', '<cmd>lua require("nvterm.terminal").toggle "horizontal"<cr>', { desc = '[T]erminal [H]orizontal' })
      -- map({ 'n', 't' }, '<a-v>', '<cmd>lua require("nvterm.terminal").toggle "vertical"<cr>', { desc = '[T]erminal [V]ertical' })

      -- -- New with <leader> -- No need since we just exit the terminal with <c-d> and toggle new terminal again
      -- -- NOTE: turn off because it's popup while I type in terminal
      -- map({ 'n', 't' }, '<leader>ti', '<cmd>lua require("nvterm.terminal").new "float"<cr>', { desc = '[T]erminal [i]Float' })
      -- map({ 'n', 't' }, '<leader>th', '<cmd>lua require("nvterm.terminal").new "horizontal"<cr>', { desc = '[T]erminal [H]orizontal' })
      -- map({ 'n', 't' }, '<leader>tv', '<cmd>lua require("nvterm.terminal").new "vertical"<cr>', { desc = '[T]erminal [V]ertical' })

      -- Open New Vertical terminal and run `test` script
      map('n', '<leader>tS', function()
        require('nvterm.terminal').send('npm run test', 'float')
      end, { desc = '[T]erminal Run Test [S]cript' })

      -- Send a command to the opened Terminal
      -- require('nvterm.terminal').send(' your command ', 'horizontal|vertical|float') -- the 2nd argument i.e direction is optional
      -- Example prompt user to type a command and send to a float terminal
      map(
        'n',
        '<leader>ts',
        '<cmd>lua require("nvterm.terminal").send(vim.fn.input"Your command: ", "float")<cr>',
        { desc = '[T]erminal [A]sk Command To Run' }
      )
    end,
  },
}
