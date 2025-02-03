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

    map('n', '<leader>ar', '<cmd>Rest run<cr>', { desc = '[A]PIs [R]un' })
    map('n', '<leader>al', '<cmd>Rest run last<cr>', { desc = '[A]PIs Run [L]ast' })
  end,
}
