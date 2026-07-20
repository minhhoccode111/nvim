-- REQUIRED SYSTEM DEPS (install before opening nvim or the luarocks build will fail):
--   1. npm install -g tree-sitter-cli
--   2. luarocks install luarocks-build-treesitter-parser
-- rest.nvim depends on tree-sitter-http, which is built from source via LuaRocks.
-- It needs the `tree-sitter` CLI to compile the parser grammar, and the
-- luarocks-build-treesitter-parser build backend to be globally accessible.
return {
  'rest-nvim/rest.nvim',

  init = function()
    vim.g.rest_nvim = {
      ui = {
        winbar = true,
        keybinds = {
          prev = 'I',
          next = 'O',
        },
      },
    }
  end,

  config = function()
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'json' },
      callback = function()
        vim.api.nvim_set_option_value('formatprg', 'jq', { scope = 'local' })
      end,
    })

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'html',
      callback = function()
        vim.bo.formatprg = 'tidy -q -indent'
      end,
    })

    local map = vim.keymap.set

    map('n', '<leader>ar', '<cmd>Rest run<cr>', { desc = '[A]PIs [R]un Under Cursor' })
    map('n', '<leader>aa', function()
      local name = vim.fn.input 'Run API name: '
      if name ~= '' then
        vim.cmd('Rest run ' .. name)
      else
        print 'Cancelled'
      end
    end, { desc = '[A]PIs Run By N[a]me' })
  end,
}
