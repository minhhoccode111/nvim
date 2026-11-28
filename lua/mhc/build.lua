-- Unified build/run keymaps for C++ and Go (auto-detect by filetype).
local cpp = require 'mhc.cpp'
local go = require 'mhc.go'

local function build()
  local ft = vim.bo.filetype
  if ft == 'cpp' then
    cpp.build()
  elseif ft == 'go' then
    go.build()
  else
    vim.notify('Build: unsupported filetype: ' .. ft, vim.log.levels.WARN)
  end
end

local function run()
  local ft = vim.bo.filetype
  if ft == 'cpp' then
    cpp.run()
  elseif ft == 'go' then
    go.run()
  else
    vim.notify('Run: unsupported filetype: ' .. ft, vim.log.levels.WARN)
  end
end

vim.keymap.set('n', '<leader>bb', build, { desc = '[B]uild: current file' })
vim.keymap.set('n', '<leader>br', run, { desc = '[B]uild: [R]un current file' })

return { build = build, run = run }