return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  config = function()
    require('nvim-treesitter').setup()

    require('nvim-treesitter').install {
      'bash',
      'go',
      'lua',
      'markdown',
      'html',
      'javascript',
      'typescript',
      'css',
      'diff',
      'xml',
      'json',
      'http',
      'gitcommit',
      'svelte',
      'templ',
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = '*',
      callback = function(args)
        local lang = vim.bo[args.buf].filetype
        if lang and vim.treesitter.query.get(lang, 'indents') then
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = true,
      },
      move = {
        set_jumps = true,
      },
    }

    local select_textobject = require('nvim-treesitter-textobjects.select').select_textobject
    local select_keys = {
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
      ['al'] = '@loop.outer',
      ['il'] = '@loop.inner',
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
    }
    for key, query in pairs(select_keys) do
      vim.keymap.set({ 'x', 'o' }, key, function()
        select_textobject(query, 'textobjects')
      end, { desc = 'TS: ' .. query })
    end

    local move = require 'nvim-treesitter-textobjects.move'
    vim.keymap.set('n', ']f', function()
      move.goto_next_start '@function.outer'
    end, { desc = 'TS: Next function start' })
    vim.keymap.set('n', ']c', function()
      move.goto_next_start '@class.outer'
    end, { desc = 'TS: Next class start' })
    vim.keymap.set('n', ']F', function()
      move.goto_next_end '@function.outer'
    end, { desc = 'TS: Next function end' })
    vim.keymap.set('n', ']C', function()
      move.goto_next_end '@class.outer'
    end, { desc = 'TS: Next class end' })
    vim.keymap.set('n', '[f', function()
      move.goto_previous_start '@function.outer'
    end, { desc = 'TS: Prev function start' })
    vim.keymap.set('n', '[c', function()
      move.goto_previous_start '@class.outer'
    end, { desc = 'TS: Prev class start' })
    vim.keymap.set('n', '[F', function()
      move.goto_previous_end '@function.outer'
    end, { desc = 'TS: Prev function end' })
    vim.keymap.set('n', '[C', function()
      move.goto_previous_end '@class.outer'
    end, { desc = 'TS: Prev class end' })
  end,
}
