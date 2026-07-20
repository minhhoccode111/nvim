return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  config = function()
    require('which-key').setup()

    require('which-key').add {
      { '<leader>A', group = '[A]ction' },
      { '<leader>A_', hidden = true },
      { '<leader>a', group = '[A]PIs' },
      { '<leader>a_', hidden = true },
      -- { '<leader>C', group = '[C]odeium' },
      -- { '<leader>C_', hidden = true },
      { '<leader>d', group = '[D]ebug' },
      { '<leader>d_', hidden = true },
      { '<leader>f', group = '[F]ind' },
      { '<leader>f_', hidden = true },
      { '<leader>h', group = 'Gitsign [H]unk' },
      { '<leader>h_', hidden = true },
      { '<leader>l', group = '[L]SP' },
      { '<leader>l_', hidden = true },
      { '<leader>ls', group = '[L]SP: [S]ymbols' },
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
