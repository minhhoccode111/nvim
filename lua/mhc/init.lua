require 'mhc.set'
require 'mhc.map'
require 'mhc.ui'

return {
  require 'mhc.plugins.autopairs',
  require 'mhc.plugins.autotag',
  require 'mhc.plugins.bufferline',
  require 'mhc.plugins.codeium',
  require 'mhc.plugins.color_schemes',
  require 'mhc.plugins.comment',
  require 'mhc.plugins.conform',
  require 'mhc.plugins.context',
  require 'mhc.plugins.dashboard',
  require 'mhc.plugins.debug',
  require 'mhc.plugins.dressing',
  require 'mhc.plugins.flutter',
  require 'mhc.plugins.gitsigns',
  require 'mhc.plugins.inc_rename',
  require 'mhc.plugins.indent_blankline',
  require 'mhc.plugins.lint',
  require 'mhc.plugins.lspconfig',
  require 'mhc.plugins.markdown_preview',
  require 'mhc.plugins.mini',
  require 'mhc.plugins.neotree',
  require 'mhc.plugins.noice',
  require 'mhc.plugins.nvimcmp',
  require 'mhc.plugins.other',
  require 'mhc.plugins.rest',
  require 'mhc.plugins.sleuth',
  require 'mhc.plugins.tailwind',
  require 'mhc.plugins.telescope',
  -- require 'mhc.plugins.termimal', -- no need after I added tmux
  require 'mhc.plugins.tmux_navigator',
  require 'mhc.plugins.todo_comments',
  require 'mhc.plugins.treesitter',
  require 'mhc.plugins.whichkey',
}