-- Markdown preview to write documents

return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  build = 'cd app && yarn install',
  init = function()
    vim.g.mkdp_filetypes = { 'markdown' }
    local map = vim.keymap.set
    map('n', '<leader>AP', '<cmd>:MarkdownPreviewToggle<cr>', { desc = '[A]ction: [P]review Markdown' })
  end,
  ft = { 'markdown' },
}
