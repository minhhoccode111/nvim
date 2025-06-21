---@diagnostic disable: unused-local
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = '<leader><space>',
    direction = 'horizontal',
    size = vim.o.lines * 0.5,
    persist_mode = false, -- enter terminal buffer with insert mode
  },
}
