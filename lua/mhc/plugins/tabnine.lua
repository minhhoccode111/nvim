-- tabnine client for neovim

return {
  'codota/tabnine-nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  build = './dl_binaries.sh',
  config = function()
    require('tabnine').setup {
      disable_auto_comment = true,
      accept_keymap = '<C-y>', -- yes
      dismiss_keymap = '<C-n>', -- no
      debounce_ms = 500,
      -- suggestion_color = { gui = '#808080', cterm = 244 },
      suggestion_color = { gui = '#00ff00', cterm = 244 },
      exclude_filetypes = { 'TelescopePrompt', 'NvimTree' },
      log_file_path = '/tmp/tabnine.log', -- absolute path to Tabnine log file
      ignore_certificate_errors = false,
      -- workspace_folders = {
      --   paths = { "/your/project" },
      --   get_paths = function()
      --       return { "/your/project" }
      --   end,
      -- },
    }
    local map = vim.keymap.set
    map('n', '<leader>Ct', '<cmd>TabnineChat<cr>', { desc = '[C]hat [T]abnine' })
    map('n', '<leader>tt', '<cmd>TabnineToggle<cr>', { desc = '[T]oggle [T]abnine' })
    -- TODO: solve problem why TabnineChat don't work on Arch linux
  end,
}

-- :TabnineStatus - to print Tabnine status
-- :TabnineDisable - to disable Tabnine
-- :TabnineEnable - to enable Tabnine
-- :TabnineToggle - to toggle enable/disable
-- :TabnineChat - to launch Tabnine chat
-- :TabnineAccept - accept apply changes
-- :TabnineReject - reject apply changes
-- :TabnineFix - to fix the function in scope
-- :TabnineTest - to generate tests for function in scope
-- :TabnineExplain - to explain the function in scope
-- :TabnineLoginWithAuthToken - to log in using auth token (for headless environments, where no browser is available)
