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
      map('n', '<leader>gj', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>gj', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = '[G]itsigns Next[j] Hunk' })

      map('n', '<leader>gk', function()
        if vim.wo.diff then
          vim.cmd.normal { '<leader>gk', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = '[G]itsigns Prev[k] Hunk' })

      -- setup keymaps
      map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[G]itsigns [S]tage Hunk' })
      map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[G]itsigns [R]eset Hunk' })
      map('v', '<leader>gs', function()
        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[G]itsigns [S]tage Hunk' })
      map('v', '<leader>gr', function()
        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
      end, { desc = '[G]itsigns [R]eset Hunk' })
      map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[G]itsigns [S]tage Hunk Buffer' })
      map('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = '[G]itsigns [U]ndo Stage Hunk' })
      map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[G]itsigns [R]eset Hunk Buffer' })
      map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[G]itsigns [P]review Hunk' })
      map('n', '<leader>gb', function()
        gitsigns.blame_line { full = true }
      end, { desc = '[G]itsigns [B]lame Line' })
      map('n', '<leader>gd', gitsigns.diffthis, { desc = '[G]itsigns [d]iff this' })
      map('n', '<leader>gD', function()
        gitsigns.diffthis '~'
      end, { desc = '[G]itsigns [D]iff ~' })
      map('n', '<leader>tB', gitsigns.toggle_current_line_blame, { desc = '[T]oggle Gitsigns [B]lame Line' })
      map('n', '<leader>tD', gitsigns.toggle_deleted, { desc = '[T]oggle Gitsigns [D]eleted Line' })
    end,
  },
}
