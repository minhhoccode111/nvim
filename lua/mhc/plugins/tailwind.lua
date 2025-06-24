-- something about tailwind

return {
  {
    'catgoose/nvim-colorizer.lua',
    event = 'BufReadPre',
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },

  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {
      document_color = {
        enabled = false,
      },
      keymaps = {
        smart_increment = {
          enabled = false,
        },
      },
    },
  },
}
