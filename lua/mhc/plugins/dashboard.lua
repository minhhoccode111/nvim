-- display greet when start

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    -- Set up your custom header/logo
    local logo = [[
███╗   ███╗██╗  ██╗ ██████╗
████╗ ████║██║  ██║██╔════╝
██╔████╔██║███████║██║     
██║╚██╔╝██║██╔══██║██║     
██║ ╚═╝ ██║██║  ██║╚██████╗
╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
    ]]

    logo = string.rep('\n', 3) .. logo .. string.rep('\n', 2)

    local builtin = require 'telescope.builtin'

    -- doom theme, or hyper theme
    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = vim.split(logo, '\n'),
        center = {
          { icon = '󰙅  ', desc = '[N]eotree Toggle          ', action = 'Neotree toggle float', key = 'n' },
          { icon = '  ', desc = '[F]iles Find              ', action = builtin.fd, key = 'f' },
          { icon = '  ', desc = '[O]ld files Find          ', action = builtin.oldfiles, key = 'o' },
          {
            icon = '󰈞  ',
            desc = '[A]ll files Find          ',
            action = function()
              builtin.fd { hidden = true, no_ignore = true }
            end,
            key = 'a',
          },
          { icon = '  ', desc = '[S]tatus Git Find         ', action = builtin.git_status, key = 's' },
          { icon = '  ', desc = '[C]onfiguration           ', action = 'edit ~/.config/nvim/init.lua', key = 'c' },
          { icon = '󰗼  ', desc = '[Q]uit                    ', action = 'q', key = 'q' },
        },
        footer = { '', '', 'Memento mori' },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
