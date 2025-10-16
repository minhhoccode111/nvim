-- format json rest.nvim
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'json' },
  callback = function()
    vim.api.nvim_set_option_value('formatprg', 'jq', { scope = 'local' })
  end,
})

-- format html rest.nvim
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'html',
  callback = function()
    vim.bo.formatprg = 'tidy -q -indent'
  end,
})

---rest.nvim default configuration
---@class rest.Config
vim.g.rest_nvim = {
  ---@class rest.Config.UI
  ui = {
    ---@type boolean Whether to set winbar to result panes
    winbar = true,
    ---@class rest.Config.UI.Keybinds
    keybinds = {
      ---@type string Mapping for cycle to previous result pane
      prev = 'I',
      ---@type string Mapping for cycle to next result pane
      next = 'O',
    },
  },
}

return {
  'rest-nvim/rest.nvim',

  config = function()
    local map = vim.keymap.set

    map('n', '<leader>ar', '<cmd>Rest run<cr>', { desc = '[A]PIs [R]un Under Cursor' })
    map('n', '<leader>aa', function()
      local name = vim.fn.input 'Run API name: '
      if name ~= '' then
        vim.cmd('Rest run ' .. name)
      else
        print 'Cancelled'
      end
    end, { desc = '[A]PIs Run By N[a]me' })
  end,
}
