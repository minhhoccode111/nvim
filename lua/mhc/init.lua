require 'mhc.set'
require 'mhc.map'
require 'mhc.ui'

return {
  -- require 'mhc.plugins.autopairs', -- replaced by mini.pairs
  -- require 'mhc.plugins.blink',
  -- require 'mhc.plugins.bufferline', -- replaced by mini.tabline + mini.bufremove
  -- require 'mhc.plugins.comment', -- replaced by mini.comment
  -- require 'mhc.plugins.dashboard',
  -- require 'mhc.plugins.flutter', -- NOTE: turn on extension in telescope too
  -- require 'mhc.plugins.git_conflict',
  -- require 'mhc.plugins.indent_blankline', -- replaced by mini.indentscope
  -- require 'mhc.plugins.markdown_render',
  -- require 'mhc.plugins.noice',
  -- require 'mhc.plugins.obsidian', -- NOTE: write note in plain text
  -- require 'mhc.plugins.oil', -- NOTE: use yazi instead
  -- require 'mhc.plugins.php',
  -- require 'mhc.plugins.supermaven',
  -- require 'mhc.plugins.tabnine',
  -- require 'mhc.plugins.terminal',
  -- require 'mhc.plugins.todo_comments', -- replaced by mini.hipatterns
  require 'mhc.plugins.autotag',
  require 'mhc.plugins.conform',
  require 'mhc.plugins.context',
  require 'mhc.plugins.dadbod',
  require 'mhc.plugins.debugger',
  require 'mhc.plugins.fugitive',
  require 'mhc.plugins.gitsigns',
  require 'mhc.plugins.go',
  require 'mhc.plugins.inc_rename',
  require 'mhc.plugins.lint',
  require 'mhc.plugins.lspconfig',
  require 'mhc.plugins.markdown_preview',
  require 'mhc.plugins.mini',
  require 'mhc.plugins.neotree',
  require 'mhc.plugins.nvimcmp', -- NOTE: migrated to blink.lua; blink disabled, nvimcmp at line 8
  require 'mhc.plugins.rest',
  require 'mhc.plugins.roslyn',
  require 'mhc.plugins.sleuth',
  require 'mhc.plugins.snacks',
  require 'mhc.plugins.tailwind',
  require 'mhc.plugins.telescope',
  require 'mhc.plugins.themes',
  require 'mhc.plugins.tmux_navigator',
  require 'mhc.plugins.treesitter',
  require 'mhc.plugins.whichkey',
}
