-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- settings
require 'minhhoccode.set'

-- keymaps
require 'minhhoccode.map'

-- plugins
return {
  require 'minhhoccode.plugins.autopairs',
  require 'minhhoccode.plugins.autotag',
  require 'minhhoccode.plugins.bufferline',
  require 'minhhoccode.plugins.colorschemes',
  require 'minhhoccode.plugins.comment',
  require 'minhhoccode.plugins.conform',
  -- require 'minhhoccode.plugins.context',
  require 'minhhoccode.plugins.gitsigns',
  require 'minhhoccode.plugins.lspconfig',
  require 'minhhoccode.plugins.markdownpreview',
  require 'minhhoccode.plugins.mini',
  require 'minhhoccode.plugins.neotree',
  require 'minhhoccode.plugins.nvimcmp',
  require 'minhhoccode.plugins.other',
  require 'minhhoccode.plugins.rest',
  require 'minhhoccode.plugins.tailwind',
  require 'minhhoccode.plugins.telescope',
  require 'minhhoccode.plugins.term',
  require 'minhhoccode.plugins.treesitter',
  require 'minhhoccode.plugins.whichkey',
}
