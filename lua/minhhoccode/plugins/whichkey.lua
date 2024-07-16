-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    -- require('which-key').register {
    --   ['<leader>a'] = { name = '[A]PIs', _ = 'which_key_ignore' },
    --   ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
    --   ['<leader>d'] = { name = '[D]iagnostic', _ = 'which_key_ignore' },
    --   ['<leader>D'] = { name = '[D]ebug', _ = 'which_key_ignore' },
    --   ['<leader>h'] = { name = 'Gitsign [H]unk', _ = 'which_key_ignore' },
    --   ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
    --   ['<leader>m'] = { name = '[M]anagers', _ = 'which_key_ignore' },
    --   ['<leader>n'] = { name = '[N]eotree', _ = 'which_key_ignore' },
    --   ['<leader>r'] = { name = '[R]eplace', _ = 'which_key_ignore' },
    --   ['<leader>t'] = { name = '[T]erminal | [T]oggle', _ = 'which_key_ignore' },
    --   ['<leader>x'] = { name = '[X]Close', _ = 'which_key_ignore' },
    --
    --   ['<leader>ls'] = { name = '[L]SP [S]ymbols', _ = 'which_key_ignore' },
    -- }

    require('which-key').add {
      { '<leader>D', group = '[D]ebug' },
      { '<leader>D_', hidden = true },
      { '<leader>a', group = '[A]PIs' },
      { '<leader>a_', hidden = true },
      { '<leader>d', group = '[D]iagnostic' },
      { '<leader>d_', hidden = true },
      { '<leader>f', group = '[F]ind' },
      { '<leader>f_', hidden = true },
      { '<leader>h', group = 'Gitsign [H]unk' },
      { '<leader>h_', hidden = true },
      { '<leader>l', group = '[L]SP' },
      { '<leader>l_', hidden = true },
      { '<leader>ls', group = '[L]SP [S]ymbols' },
      { '<leader>ls_', hidden = true },
      { '<leader>m', group = '[M]anagers' },
      { '<leader>m_', hidden = true },
      { '<leader>n', group = '[N]eotree' },
      { '<leader>n_', hidden = true },
      { '<leader>r', group = '[R]eplace' },
      { '<leader>r_', hidden = true },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>t_', hidden = true },
      { '<leader>x', group = '[X]Close' },
      { '<leader>x_', hidden = true },
    }

    -- require('which-key').show {
    --   keys = 's',
    --   loop = true, -- this will keep the popup open until you hit <esc>
    -- }
  end,
}
