-- other tiny plugins

return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

  -- navigate tmux the same as in neovim using <C-hjkl>
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    -- { 'windwp/nvim-ts-autotag' },
    -- opts = {},
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- display buffer tabs at the top
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  -- improve default vim.ui interfaces
  {
    'stevearc/dressing.nvim',
    opts = {},
  },

  -- comments highlight
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}

--[[
NOTE:
TODO:
FIXME:
FIX:
BUG:
WARN:
HACK:
PERF:
TEST:
]]
--
