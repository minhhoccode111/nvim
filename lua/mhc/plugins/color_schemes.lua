-- colorschemes

return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'randomhue'
      -- vim.cmd.colorscheme 'catppuccin-macchiato'
      vim.cmd.colorscheme 'catppuccin-mocha'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  -- another colorschemes
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },

  {
    'EdenEast/nightfox.nvim',
    priority = 1000,
  },

  {
    'sainnhe/everforest',
    priority = 1000,
  },

  {
    'morhetz/gruvbox',
    priority = 1000,
  },

  {
    'navarasu/onedark.nvim',
    priority = 1000,
  },

  {
    'ayu-theme/ayu-vim',
    priority = 1000,
  },

  {
    'sainnhe/gruvbox-material',
    priority = 1000,
  },

  {
    'sainnhe/sonokai',
    priority = 1000,
  },

  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
  },

  {
    'Mofiqul/dracula.nvim',
    priority = 1000,
  },

  {
    'joshdick/onedark.vim',
    priority = 1000,
  },

  {
    'cocopon/iceberg.vim',
    priority = 1000,
  },
}
