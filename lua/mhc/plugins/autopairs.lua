-- print 'Hello, World! From autopair.lua'

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {
      -- My custom override
      map_c_h = true, -- map the <c-h> key to delete a pair
      map_c_w = true, -- map the <c-w> key to delete a pair if possible
      disable_filetype = {
        'TelescopePrompt',
        'spectre_panel',
        'vim', -- since the " is comment
      },
    }

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
