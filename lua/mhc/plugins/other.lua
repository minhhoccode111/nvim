-- other tiny plugins

return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  { 'tpope/vim-sleuth' }, -- Detect tabstop and shiftwidth automatically

  -- navigate tmux the same as in neovim
  {
    'christoomey/vim-tmux-navigator',
    lazy = false,
  },

  {
    -- { 'windwp/nvim-ts-autotag' },
    -- opts = {},
  },
}
