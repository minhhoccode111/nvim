-- Autocompletion with minuet-ai.nvim

return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  build = 'cargo build --release',
  dependencies = {
    {
      'milanglacier/minuet-ai.nvim',
      dependencies = {
        { 'nvim-lua/plenary.nvim' },
      },
      config = function()
        require('minuet').setup {
          -- Choose your provider - examples:
          -- For OpenAI: provider = 'openai'
          -- For Claude: provider = 'claude'
          -- For Gemini: provider = 'gemini'
          -- For Codestral: provider = 'codestral'
          -- For OpenRouter/Groq/Fireworks: provider = 'openai_compatible'
          -- For Ollama/local: provider = 'openai_fim_compatible'

          provider = 'gemini', -- Change this to your preferred provider

          -- Recommended settings to prevent timeouts
          request_timeout = 3,
          throttle = 1000,
          debounce = 400,

          -- Provider-specific options
          provider_options = {
            -- Example for Codestral (default provider)
            -- codestral = {
            --   model = 'codestral-latest',
            --   api_key = 'CODESTRAL_API_KEY', -- Environment variable name
            --   stream = true,
            --   optional = {
            --     max_tokens = 256,
            --     stop = { '\n\n' },
            --   },
            -- },

            -- Uncomment and configure your preferred provider:

            -- OpenAI
            -- openai = {
            --   model = 'gpt-4.1-mini',
            --   api_key = 'OPENAI_API_KEY',
            --   stream = true,
            --   optional = {
            --     max_tokens = 256,
            --   },
            -- },

            -- Claude
            -- claude = {
            --   model = 'claude-3-5-haiku-20241022',
            --   api_key = 'ANTHROPIC_API_KEY',
            --   max_tokens = 512,
            --   stream = true,
            -- },

            -- Gemini
            gemini = {
              model = 'gemini-2.0-flash',
              api_key = 'GEMINI_API_KEY',
              stream = true,
              optional = {
                generationConfig = {
                  maxOutputTokens = 256,
                },
              },
            },

            -- OpenRouter/Groq/Fireworks (openai_compatible)
            -- openai_compatible = {
            --   model = 'mistralai/devstral-small-2505',
            --   end_point = 'https://openrouter.ai/api/v1/chat/completions',
            --   api_key = 'OPENROUTER_API_KEY',
            --   name = 'Openrouter',
            --   stream = true,
            --   optional = {
            --     max_tokens = 256,
            --   },
            -- },

            -- Ollama (local FIM model)
            -- openai_fim_compatible = {
            --   api_key = 'TERM', -- Placeholder for local model
            --   name = 'Ollama',
            --   end_point = 'http://localhost:11434/v1/completions',
            --   model = 'qwen2.5-coder:7b',
            --   stream = true,
            --   optional = {
            --     max_tokens = 256,
            --     top_p = 0.9,
            --   },
            -- },
          },
        }
      end,
    },
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
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      -- preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      -- Using custom keymap to preserve your original nvim-cmp mappings

      -- TODO: turn on
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

      -- Manual minuet completion trigger (optional)
      ['<A-y>'] = {
        function(cmp)
          cmp.show { providers = { 'minuet' } }
        end,
      },
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
        'minuet',
      },
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100,
        },
        minuet = {
          name = 'minuet',
          module = 'minuet.blink',
          async = true,
          -- Should match minuet request_timeout * 1000
          timeout_ms = 3000,
          -- Higher priority for AI completions
          score_offset = 50,
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
