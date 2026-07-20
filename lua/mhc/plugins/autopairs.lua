return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {
      map_c_h = true,
      map_c_w = true,
      disable_filetype = {
        'TelescopePrompt',
        'spectre_panel',
        'vim',
      },
    }
  end,
}
