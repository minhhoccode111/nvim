-- lazy.nvim
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = function()
    require('noice').setup {
      presets = { inc_rename = true },
    }

    -- -- calculate the dynamic window size
    -- local function calculate_size()
    --   local ui = vim.api.nvim_list_uis()[1] -- Get current Neovim UI dimensions
    --   local aspect_ratio = 0.5 -- Define your desired aspect ratio
    --   local width = math.floor(ui.width * aspect_ratio)
    --   local height = math.floor(ui.height * aspect_ratio)
    --   return { width = width, height = height }
    -- end

    -- require('noice').setup {
    --   views = {
    --     popup = {
    --       size = calculate_size(), -- Use calculated size dynamically
    --     },
    --   },
    -- }

    -- require('notify').setup {
    --   render = 'compact',
    --   on_open = function(win)
    --     local size = calculate_size()
    --     vim.api.nvim_win_set_config(win, {
    --       width = size.width,
    --       height = size.height,
    --     })
    --   end,
    -- }
  end,
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    { 'rcarriga/nvim-notify', opts = {
      render = 'compact',
    } },
  },
}
