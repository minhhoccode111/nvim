-- "gc" to comment visual regions/lines
return {
  'numToStr/Comment.nvim',
  opts = {
    -- gc will wait for any movement next to toggle comment line
    --[[ gb will wait for any movement next to toggle comment block ]]

    -- mine, after selected text with visual mode <C-/> to toggle line comment
    vim.keymap.set('n', '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise.current() <cr>', { desc = 'Comment Toggle' }),
    -- <C-/> in tmux will input ^_ (or <C-_>)
    vim.keymap.set('n', '<C-_>', '<cmd>lua require("Comment.api").toggle.linewise.current() <cr>', { desc = 'Comment Toggle' }),

    -- From Insert mode > Comment > indent > back to Insert mode > space
    vim.keymap.set('i', '<C-/>', '<esc><cmd>lua require("Comment.api").toggle.linewise.current()<cr>==A ', { desc = 'Comment Toggle' }),
    vim.keymap.set('i', '<C-_>', '<esc><cmd>lua require("Comment.api").toggle.linewise.current()<cr>==A ', { desc = 'Comment Toggle' }),

    vim.keymap.set('v', '<C-/>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Comment Toggle' }),
    vim.keymap.set('v', '<C-_>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Comment Toggle' }),
  },
}
