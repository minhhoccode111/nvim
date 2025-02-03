-- resolve conflict in git

return {
  'akinsho/git-conflict.nvim',
  version = '*',
  opts = {
    default_mappings = false, -- disable buffer local mapping created by this plugin
    default_commands = true, -- disable commands created by this plugin
    disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
    list_opener = 'copen', -- command or function to open the conflicts list
    highlights = { -- They must have background color, otherwise the default color will be used
      incoming = 'DiffAdd',
      current = 'DiffText',
    },
  },
  config = function()
    local map = vim.keymap.set

    -- keymaps to choose when in nvimdiff in git mergetool

    -- h for left
    map('n', 'ch', '<cmd>GitConflictChooseOurs<cr>')
    -- l for right
    map('n', 'cl', '<cmd>GitConflictChooseTheirs<cr>')
    -- a for all
    map('n', 'ca', '<cmd>GitConflictChooseBoth<cr>')
    -- n for none
    map('n', 'cn', '<cmd>GitConflictChooseNone<cr>')

    -- map('n', '[x', '<Plug>(git-conflict-prev-conflict)')
    -- map('n', ']x', '<Plug>(git-conflict-next-conflict)')
  end,
}
