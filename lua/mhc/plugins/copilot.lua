return {
  'github/copilot.vim',
  cmd = 'Copilot',
  config = function()
    vim.cmd 'Copilot enable'
  end,
}
