-- Highlight, edit, and navigate code

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'rust',
      'lua',
      'luadoc',
      'vim',
      'vimdoc',
      'markdown',
      'markdown_inline',
      'html',
      'javascript',
      'typescript',
      'jsdoc',
      'css',
      'diff',
      'xml',
      'json',
      'http',
      'graphql',
      'gitcommit',
      'c_sharp',
      'dart',
    },

    --[[ -- autotag for react
    autotag = {
      enable = true,
    }, ]]

    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      -- `false` will disable whole extension
      enable = true,
      -- list of language that will be disabled
      disable = {
        'c',
        -- 'rust',
        'markdown',
      },
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
  },
  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)

    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  end,
}
