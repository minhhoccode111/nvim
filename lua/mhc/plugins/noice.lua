---@diagnostic disable: missing-fields
-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = function()
    require('noice').setup {
      presets = { inc_rename = true }, -- preview rename variable plugin
      routes = {
        {
          filter = {
            event = 'msg_show', -- Filter messages displayed in `msg_show` events
            find = 'LSP%[omnisharp%]: Error INVALID_SERVER_MESSAGE: nil', -- Pattern to match
          },
          opts = { skip = true }, -- Skip this message
        },
      },
    }

    vim.notify = require 'notify'
    vim.notify 'Get good at your craft'
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    {
      'rcarriga/nvim-notify',
      opts = {
        render = 'compact', -- oneline to take less space
        top_down = false, -- bottom for less distraction
        stages = 'static',
      },
    },
  },
}

-- LSP[omnisharp]: Error INVALID_SERVER_MESSAGE: nil
