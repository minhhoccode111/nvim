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

    logo = string.rep('\n', 8) .. logo .. '\n\n\n'

    local builtin = require 'telescope.builtin'

    -- doom theme, or hyper theme
    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = vim.split(logo, '\n'),
        center = {
          { icon = '  ', desc = '[N]ew file                ', action = 'enew', key = 'n' },
          { icon = '  ', desc = 'Find [F]iles              ', action = builtin.fd, key = 'f' },
          { icon = '  ', desc = 'Find [O]ld files          ', action = builtin.oldfiles, key = 'o' },
          {
            icon = '󰈞  ',
            desc = 'Find [A]ll files          ',
            action = function()
              builtin.fd { hidden = true, no_ignore = true }
            end,
            key = 'a',
          },
          { icon = '  ', desc = 'Find git [S]tatus         ', action = builtin.git_status, key = 's' },
          { icon = '  ', desc = '[C]onfiguration           ', action = 'edit ~/.config/nvim/init.lua', key = 'c' },
        },
        footer = { '', '', 'Memento mori' },
      },
    }
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}
