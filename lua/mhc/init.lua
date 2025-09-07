require 'mhc.set'
require 'mhc.map'
require 'mhc.ui'

return {
  require 'mhc.plugins.autopairs',
  require 'mhc.plugins.autotag',
  -- require 'mhc.plugins.blink',
  require 'mhc.plugins.bufferline',
  require 'mhc.plugins.codeium',
  require 'mhc.plugins.comment',
  require 'mhc.plugins.conform',
  require 'mhc.plugins.context',
  -- require 'mhc.plugins.dashboard',
  require 'mhc.plugins.debugger',
  require 'mhc.plugins.flutter', -- NOTE: turn on extension in telescope too
  -- require 'mhc.plugins.git_conflict',
  require 'mhc.plugins.gitsigns',
  -- require 'mhc.plugins.gopher', -- TODO: add gopher.nvim plugin
  require 'mhc.plugins.inc_rename',
  require 'mhc.plugins.indent_blankline',
  require 'mhc.plugins.lint',
  require 'mhc.plugins.lspconfig',
  require 'mhc.plugins.markdown_preview',
  require 'mhc.plugins.mini',
  require 'mhc.plugins.neotree',
  require 'mhc.plugins.noice',
  require 'mhc.plugins.nvimcmp', -- NOTE: migrated to blink.lua
  -- require 'mhc.plugins.obsidian', -- NOTE: write note in plain text
  -- require 'mhc.plugins.oil', -- NOTE: use yazi instead
  require 'mhc.plugins.other',
  require 'mhc.plugins.php',
  require 'mhc.plugins.rest',
  require 'mhc.plugins.sleuth',
  require 'mhc.plugins.snacks',
  -- require 'mhc.plugins.tabnine',
  require 'mhc.plugins.tailwind',
  require 'mhc.plugins.telescope',
  require 'mhc.plugins.terminal',
  require 'mhc.plugins.themes',
  require 'mhc.plugins.tmux_navigator',
  require 'mhc.plugins.todo_comments',
  require 'mhc.plugins.treesitter',
  require 'mhc.plugins.whichkey',
}
