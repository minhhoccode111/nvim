---@diagnostic disable: missing-fields

return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = function()
    require('noice').setup {
      presets = { inc_rename = true }, -- preview rename variable plugin
      routes = {
        -- Suppress annoying LSP-related error messages
        {
          filter = {
            event = 'msg_show',
            find = 'LSP%[omnisharp%]: Error INVALID_SERVER_MESSAGE: nil',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            find = 'Error executing vim.schedule lua callback',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            find = 'vim.lsp.util',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'msg_show',
            find = 'client.notify is deprecated',
          },
          opts = { skip = true },
        },
        {
          filter = {
            event = 'notify',
            kind = 'warn',
            find = 'position_encoding param is required in vim.lsp.util.make_position_params',
          },
          opts = { skip = true },
        },
      },
    }

    vim.notify = require 'notify'
    vim.notify 'Welcome Minh! How are you doing today?'

    -- Keymap to notify the current file path
    vim.keymap.set('n', '<leader>no', function()
      local filepath = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
      vim.notify(filepath, 'info', { title = 'Path' })
    end, { desc = '[N][o]tify current file path' })
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
        timeout = 7000,
        fps = 60,
      },
    },
  },
}
