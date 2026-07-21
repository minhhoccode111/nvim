-- Collection of various small independent plugins/modules
-- Replaces: Comment.nvim, nvim-autopairs, indent-blankline, bufferline, todo-comments

return {
  'echasnovski/mini.nvim',
  config = function()
    local map = vim.keymap.set

    ----------------------------------------
    -- mini.ai — Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    ----------------------------------------
    -- mini.surround — Add/delete/replace surroundings
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup {
      n_lines = 500,
      custom_surroundings = {
        ['('] = { output = { left = '(', right = ')' } },
        ['{'] = { output = { left = '{', right = '}' } },
        ['['] = { output = { left = '[', right = ']' } },
        ['<'] = { output = { left = '<', right = '>' } },
      },
    }

    ----------------------------------------
    -- mini.bufremove — Safe buffer deletion (replaces :bd)
    require('mini.bufremove').setup()

    -- Buffer management keymaps
    map('n', '<leader>xb', function()
      require('mini.bufremove').delete()
    end, { desc = '[X]Close [B]uffer' })

    map('n', '<leader>xp', function()
      local current = vim.api.nvim_get_current_buf()
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      local items = {}
      for _, buf in ipairs(buffers) do
        if buf.bufnr ~= current then
          table.insert(items, buf)
        end
      end
      if #items == 0 then
        vim.notify('No other buffers to close', vim.log.levels.WARN)
        return
      end
      vim.ui.select(items, {
        prompt = 'Pick buffer to close:',
        format_item = function(item)
          return (item.name and item.name ~= '' and vim.fn.fnamemodify(item.name, ':t')) or '[No Name]'
        end,
      }, function(choice)
        if choice then
          require('mini.bufremove').delete(choice.bufnr)
        end
      end)
    end, { desc = '[X]Close [P]ick Buffer' })

    map('n', '<leader>xo', function()
      local current = vim.api.nvim_get_current_buf()
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      for _, buf in ipairs(buffers) do
        if buf.bufnr ~= current then
          pcall(require('mini.bufremove').delete, buf.bufnr, false)
        end
      end
    end, { desc = '[X]Close [O]ther Buffers' })

    map('n', '<leader>xl', function()
      local current = vim.api.nvim_get_current_buf()
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      for _, buf in ipairs(buffers) do
        if buf.bufnr == current then
          break
        end
        pcall(require('mini.bufremove').delete, buf.bufnr, false)
      end
    end, { desc = '[X]Close Buffers to [L]eft' })

    map('n', '<leader>xr', function()
      local current = vim.api.nvim_get_current_buf()
      local buffers = vim.fn.getbufinfo { buflisted = 1 }
      local found = false
      for _, buf in ipairs(buffers) do
        if found then
          pcall(require('mini.bufremove').delete, buf.bufnr, false)
        end
        if buf.bufnr == current then
          found = true
        end
      end
    end, { desc = '[X]Close Buffers to [R]ight' })

    ----------------------------------------
    -- mini.hipatterns — Highlight patterns (replaces todo-comments.nvim)
    require('mini.hipatterns').setup {
      highlighters = {
        fixme = { pattern = 'FIXME', group = 'DiagnosticError' },
        todo = { pattern = 'TODO', group = 'DiagnosticWarn' },
        hack = { pattern = 'HACK', group = 'DiagnosticWarn' },
        warn = { pattern = 'WARN', group = 'DiagnosticWarn' },
        perf = { pattern = 'PERF', group = 'DiagnosticHint' },
        note = { pattern = 'NOTE', group = 'DiagnosticInfo' },
        test = { pattern = 'TEST', group = 'DiagnosticHint' },
        bug = { pattern = 'BUG', group = 'DiagnosticError' },
        fix = { pattern = 'FIX', group = 'DiagnosticError' },
      },
    }

    ----------------------------------------
    -- mini.statusline — Minimal statusline
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
