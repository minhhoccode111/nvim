-- comments highlight

return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false },
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
