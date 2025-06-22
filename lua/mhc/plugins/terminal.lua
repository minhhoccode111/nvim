---@diagnostic disable: unused-local
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = '<leader><space>',
    direction = 'horizontal',
    size = vim.o.lines * 0.5,
    -- if set to true (default) the previous terminal mode will be remembered
    -- set to 'false' to use 'insert' mode every time enter terminal buffer
    persist_mode = false,
    -- whether or not the open mapping applies in insert mode
    insert_mappings = false,
  },
}
