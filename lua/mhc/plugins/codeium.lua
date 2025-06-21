-- codeium client for neovim

return {
  'Exafunction/codeium.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
  },
  config = function()
    require('codeium').setup {
      enable_cmp_source = true,
      virtual_text = {
        enable = true,
        -- key_bindings = {
        --   accept = '<C-y>',
        --   clear = '<C-;>',
        --   next = '<C-j>',
        --   prev = '<C-k>',
        -- },
      },
    }

    local map = vim.keymap.set
    map('n', '<leader>AC', '<cmd>Codeium Chat<cr>', { desc = '[A]ction: [C]odeium [C]hat' })

    -- map('i', '<C-y>', function()
    --   require('codeium.virtual_text').complete()
    -- end, { expr = true, silent = true })
    --
    -- map('i', '<c-j>', function()
    --   require('codeium.virtual_text').cycle_completions(1)
    -- end, { expr = true, silent = true })
    -- map('i', '<c-k>', function()
    --   require('codeium.virtual_text').cycle_completions(-1)
    -- end, { expr = true, silent = true })
    -- map('i', '<c-;>', function()
    --   require('codeium.virtual_text').clear()
    -- end, { expr = true, silent = true })
  end,
}

-- codeium#Clear()
-- codeium#CycleCompletions(1)
-- codeium#CycleCompletions(-1)
-- codeium#Accept()
-- codeium#Complete()
-- codeium#AcceptNextWord()
-- codeium#AcceptNextLine()
