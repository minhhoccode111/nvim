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
      end, { desc = 'Gitsigns Next[j] [H]unk' })

      map('n', '<leader>hk', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>hk', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Gitsigns Prev[k] [H]unk' })

      -- navigation but quicker
      map('n', '<leader>J', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>hj', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Gitsigns Next[j] [H]unk' })

      map('n', '<leader>K', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>hk', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Gitsigns Prev[k] [H]unk' })

      -- setup keymaps
      map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Gitsigns [S]tage [H]unk' })
      map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'Gitsigns [R]eset [H]unk' })
      map('v', '<leader>hs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Gitsigns [S]tage [H]unk' })
      map('v', '<leader>hr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = 'Gitsigns [R]eset [H]unk' })
      map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'Gitsigns [S]tage [H]unk Buffer' })
      map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'Gitsigns [U]ndo Stage [H]unk' })
      map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'Gitsigns [R]eset [H]unk Buffer' })
      map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'Gitsigns [P]review [H]unk' })
      map('n', '<leader>hb', function()
        gitsigns.blame_line { full = true }
      end, { desc = 'Gitsigns [B]lame Line' })
      map('n', '<leader>hd', gitsigns.diffthis, { desc = 'Gitsigns [d]iff this (vs staged)' })
      map('n', '<leader>hD', function()
        gitsigns.diffthis '~'
      end, { desc = 'Gitsigns [D]iff ~ (vs last commit)' })
      map('n', '<leader>tB', gitsigns.toggle_current_line_blame, { desc = '[T]oggle Gitsigns [B]lame Line' })
      map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle Gitsigns [D]eleted Line' })
    end,
  },
}
