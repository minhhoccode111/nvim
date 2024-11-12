require 'mhc.set'
require 'mhc.map'
require 'mhc.ui'

return {
  require 'mhc.plugins.autopairs',
  require 'mhc.plugins.autotag',
  require 'mhc.plugins.colorschemes',
  require 'mhc.plugins.comment',
  require 'mhc.plugins.conform',
  -- require 'mhc.plugins.context', -- turn on if needed
  require 'mhc.plugins.debug',
  require 'mhc.plugins.flutter',
  require 'mhc.plugins.gitsigns',
  require 'mhc.plugins.lint',
  require 'mhc.plugins.lspconfig',
  require 'mhc.plugins.markdownpreview',
  require 'mhc.plugins.mini',
  require 'mhc.plugins.neotree',
  require 'mhc.plugins.nvimcmp',
  require 'mhc.plugins.other',
  require 'mhc.plugins.rest',
  require 'mhc.plugins.tailwind',
  require 'mhc.plugins.telescope',
  -- require 'mhc.plugins.termimal', -- no need after I added tmux
  require 'mhc.plugins.treesitter',
  require 'mhc.plugins.whichkey',
}
