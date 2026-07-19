-- Autocompletion

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  build = 'cargo build --release',
  dependencies = {
    -- blink.compat for compatibility
    { 'saghen/blink.compat', opts = { enable_events = true } },
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    { 'folke/lazydev.nvim' },
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'none',
      ['<C-n>'] = { 'select_next', 'fallback' },
      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-y>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'accept', 'fallback' },
      ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-o>'] = { 'snippet_forward', 'fallback' },
      ['<C-i>'] = { 'snippet_backward', 'fallback' },
      ['<C-e>'] = { 'hide', 'fallback' },
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
      -- Recommended to avoid unnecessary requests for minuet
      trigger = { prefetch_on_insert = false },
    },

    sources = {
      default = {
        'lazydev',
        'lsp',
        'snippets',
        'path',
        'buffer',
      },
      per_filetype = {
        sql = { 'dadbod', 'lsp', 'snippets', 'buffer' },
        mysql = { 'dadbod', 'lsp', 'snippets', 'buffer' },
        plsql = { 'dadbod', 'lsp', 'snippets', 'buffer' },
      },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        dadbod = {
          name = 'dadbod',
          module = 'vim_dadbod_completion.blink',
        },
      },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = {
      -- implementation = 'lua',
      implementation = 'prefer_rust', -- change to 'rust' when it's stable :)
    },

    -- Shows a signature help window while you type arguments for a function
    -- signature = { enabled = true },
  },
}
