return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  -- for all markdown files
  ft = 'markdown',
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   'BufReadPre ~/Documents/notes/**/*.md',
  --   'BufNewFile ~/Documents/notes/**/*.md',
  --   'BufReadPre ~/Documents/current-obsidian/**/*.md',
  --   'BufNewFile ~/Documents/current-obsidian/**/*.md',
  -- },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  init = function()
    vim.opt.conceallevel = 1

    require('obsidian').setup {
      workspaces = {
        {
          name = 'notes',
          path = '~/Documents/notes/',
        },
        {
          name = 'current-obsidian',
          path = '~/Documents/current-obsidian/',
        },
      },
    }
  end,
}
