-- filetree in neovim

return {
  -- File: lua/custom/plugins/filetree.lua
  'nvim-neo-tree/neo-tree.nvim',

  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function(arg)
            vim.cmd [[
          setlocal relativenumber
        ]]
          end,
        },
      },
      filesystem = {
        filtered_items = {
          -- hide_dotfiles = false,
          -- hide_gitignored = false,
          never_show = {
            '.git',
            'node_modules',
          },
          always_show = { -- remains visible even if other settings would normally hide it
            '.gitignore',
            '.github',
            '.env',
            '.env.test',
            '.env.production',
            '.env.development',
            '.env.dev',
            '.env.prod',
          },
        },
        window = {
          mappings = {
            ['l'] = 'set_root',
            ['h'] = 'navigate_up',

            ['_'] = 'open_split',
            ['|'] = 'open_vsplit',

            ['Q'] = 'close_all_nodes',
            ['A'] = 'expand_all_nodes', -- like use 'tree' command in the terminal

            -- ['H'] = 'toggle_hidden',
            ['L'] = 'focus_preview',
            ['w'] = 'open',

            ['/'] = 'none', -- to quick jumping with /
            ['z'] = 'none', -- since we want to center screen
            -- ['o'] = 'open',
            -- ['oc'] = 'none',
            -- ['od'] = 'none',
            -- ['og'] = 'none',
            -- ['om'] = 'none',
            -- ['on'] = 'none',
            -- ['os'] = 'none',
            -- ['ot'] = 'none',
          },
        },
      },
    }

    -- My setting neotree keymaps, see :help neotree
    -- local command = require 'neo-tree.command'
    local map = vim.keymap.set

    -- since we don't need a file tree that much so a little deep is ok
    -- since we spend half screen for editor (usually) so float is better
    map('n', '<c-n>', '<cmd> Neotree toggle float<cr>', { desc = '[N]eotree [F]loat' })
    map('n', '<leader>nf', '<cmd> Neotree toggle float<cr>', { desc = '[N]eotree [F]loat' })
    map('n', '<leader>nl', '<cmd> Neotree toggle left <cr>', { desc = '[N]eotree [L]eft' })
    map('n', '<leader>nr', '<cmd> Neotree toggle right <cr>', { desc = '[N]eotree [R]ight' })
    -- display the filetree and reveal current file location
    map('n', '<leader>nc', '<cmd> Neotree reveal <cr>', { desc = '[N]eotree Reveal [C]urrent File' })
  end,
}
