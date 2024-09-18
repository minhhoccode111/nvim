-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return { -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    -- mine
    on_attach = function(bufnr)
      -- basic setup
      local gitsigns = require 'gitsigns'
      local function map(mode, l, r, opts)
        opts = opts or { desc = 'No description set.' }
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- mine
      -- Navigation
      map('n', '<leader>hj', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>hj', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Next[j] Hunk' })

      map('n', '<leader>hk', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>hk', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Prev[k] Hunk' })

      -- setup keymaps
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = '[S]tage Hunk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = '[R]eset Hunk' })
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[S]tage Hunk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[R]eset Hunk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = '[S]tage Hunk Buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = '[U]ndo Stage Hunk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = '[R]eset Hunk Buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = '[P]review Hunk' })
      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end, { desc = '[B]lame Line' })
      map('n', '<leader>tB', gitsigns.toggle_current_line_blame, { desc = '[T]oggle Gitsigns [B]lame Line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = '[d]iff this' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '~'
      end, { desc = '[D]iff ~' })
      map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle Gitsigns [D]eleted Line' })
    end,
  },
}
