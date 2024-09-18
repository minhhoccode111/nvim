-- NOTE: Plugins can also be added by using a table,
-- with the first argument being the link and the following
-- keys can be used to configure plugin behavior/loading/etc.
--
-- Use `opts = {}` to force a plugin to be loaded.
--
-- This is equivalent to:
--   require('Comment').setup({})

-- "gc" to comment visual regions/lines
return {
  'numToStr/Comment.nvim',
  opts = {
    -- gc will wait for any movement next to toggle comment line
    --[[ gb will wait for any movement next to toggle comment block ]]

    -- mine, after selected text with visual mode <C-/> to toggle line comment
    vim.keymap.set('n', '<C-/>', '<cmd>lua require("Comment.api").toggle.linewise.current() <cr>', { desc = 'Comment Toggle' }),

    -- From Insert mode > Comment > indent > back to Insert mode > space
    vim.keymap.set('i', '<C-/>', '<esc><cmd>lua require("Comment.api").toggle.linewise.current()<cr>==A ', { desc = 'Comment Toggle' }),

    vim.keymap.set('v', '<C-/>', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'Comment Toggle' }),
  },
}
