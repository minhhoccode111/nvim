-- Reload buffers that changed on disk outside of Neovim.
--
-- The problem: an LLM (or any other process) edits a file while Neovim has it
-- open. Neovim keeps the old text in memory and never re-reads the file. gopls,
-- on the other hand, watches the filesystem and *does* see the new content. Two
-- different versions of the same file now exist: gopls analyses the new one,
-- but Neovim keeps feeding it the stale buffer. Diagnostics land on the wrong
-- lines and pile up, and `:LspRestart` "fixes" it only because it throws both
-- copies away and rebuilds from disk.
--
-- `autoread` alone is not enough: Neovim only checks the file on a handful of
-- events. The autocommand below adds the events that matter when an external
-- process writes to a file you are not typing in.
--
-- LIMIT: this still only checks when one of these events fires. If an external
-- edit lands while the cursor sits still in that exact buffer, the buffer stays
-- stale until you switch window/buffer or move the cursor. The next step up is
-- a real filesystem watcher (`vim._watch` on the project root, Neovim 0.10+)
-- that reloads the moment the file changes.
--
-- Modified buffers are left alone: `:checktime` refuses to reload a buffer with
-- unsaved changes, so this can never clobber edits you made in Neovim.

vim.o.autoread = true

vim.api.nvim_create_autocmd({ 'FocusGained', 'BufEnter', 'CursorHold', 'TermClose', 'TermLeave' }, {
  desc = 'Re-read buffers changed on disk (external/LLM edits, git operations)',
  group = vim.api.nvim_create_augroup('mhc-autoread', { clear = true }),
  callback = function()
    -- Skip the command-line window: `:checktime` there would act on the wrong
    -- buffer and drop you out of it.
    if vim.fn.getcmdwintype() == '' then
      vim.cmd 'checktime'
    end
  end,
})

return {}
