return {
  'nvim-telescope/telescope.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = "make CFLAGS='-O3 -Wall -fpic -std=gnu99 -shared'",
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    'nvim-telescope/telescope-ui-select.nvim',

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local actions = require 'telescope.actions'

    require('telescope').setup {
      defaults = {
        -- this set live_grep and grep_string include hidden files by default
        vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--hidden',
          '--no-ignore',

          '--glob',
          '!.git/', -- exclude git dir

          '--glob',
          '!dist/', -- exclude js

          '--glob',
          '!build/', -- exclude js

          '--glob',
          '!node_modules/', -- exclude js

          '--glob',
          '!.next/', -- exclude js

          '--glob',
          '!obj/', -- exclude c#

          '--glob',
          '!bin/', -- exclude c#

          '--glob',
          '!*lock*', -- exclude lock files

          '--glob',
          '!*ca.crt*', -- exclude cert files

          -- '--glob', '!exclude_dir/', -- add more rules if needed
        },
        mappings = {
          i = {
            ['<c-u>'] = false,
            ['<c-enter>'] = 'to_fuzzy_refine',
            ['<tab>'] = actions.select_default,
          },
          -- n = { ['<tab>'] = require('telescope.actions').select_default },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(function()
      ---@type any
      local utils = require 'telescope.previewers.utils'
      utils.ts_highlighter = function(bufnr, ft)
        local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
        if not ok then
          return false
        end
        local ok2, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
        if not ok2 then
          return false
        end
        vim.treesitter.highlighter.new(parser --[[@as vim.treesitter.LanguageTree]])
        return true
      end
    end)

    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'rest'
    -- require('telescope').load_extension 'flutter' -- NOTE: turn on the plugin in mhc/init.lua too

    -- See `:help telescope.builtin`
    -- mine
    local builtin = require 'telescope.builtin'
    local map = vim.keymap.set
    map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    map('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    map('n', '<leader>ff', function()
      builtin.fd {
        follow = true,
        file_ignore_patterns = {
          'frontend', -- ignore nested frontend project
        },
      }
    end, { desc = '[F]ind [F]iles' })
    map('n', '<leader>fS', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    map('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind Current [W]ord' })
    map('n', '<leader>fg', function()
      local input = vim.fn.input 'rg > '
      if input == '' then return end
      builtin.grep_string { search = input }
    end, { desc = '[F]ind [G]rep String' })
    map('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    map('n', '<leader>fo', builtin.oldfiles, { desc = '[F]ind [O]ld (Opened) Files' })
    map('n', '<leader>fb', builtin.buffers, { desc = '[F]ind Current [B]uffers' })
    map('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
    map('n', '<leader>fc', builtin.git_commits, { desc = '[F]ind Git [c]ommits' })
    map('n', '<leader>fs', builtin.git_status, { desc = '[F]ind Git [S]tatus' })
    map('n', '<c-p>', builtin.resume, { desc = '[F]ind [R]esume' })
    map('n', '<leader>fa', function()
      builtin.fd {
        no_ignore = true,
        hidden = true,
        follow = true,
        file_ignore_patterns = {
          '.git/',
          'node_modules/',
          'frontend/',
          '.next/',
          'obj/',
          'bin/',
          'build/',
          'dist/',
          'public/',
        },
      }
    end, { desc = '[F]ind [A]ll files' })

    -- rest extension to choose env file for rest.nvim
    map('n', '<leader>fe', function()
      require('telescope').extensions.rest.select_env()
    end, { desc = '[F]ind [E]nv File Rest.nvim' })

    -- Slightly advanced example of overriding default behavior and theme
    map('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    map('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep',
      }
    end, { desc = '[F]ind [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    map('n', '<leader>fN', function()
      builtin.fd { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[F]ind [N]eovim files' })

    -- Shortcut for searching my /dotfiles dir
    map('n', '<leader>fD', function()
      builtin.fd { cwd = '~/dotfiles', hidden = false, no_ignore = false }
    end, { desc = '[F]ind /[d]otfiles dir' })

    -- -- Shortcut for searching my /Documents/current-obsidian dir
    map('n', '<leader>fO', function()
      builtin.fd { cwd = '~/Documents/current-obsidian/', hidden = true, no_ignore = true }
    end, { desc = '[F]ind [o]bsidian dir' })

    -- prompt user to add a path to local variables
    local current_cwd = nil
    local current_hidden = true
    local current_noignore = false
    map('n', '<leader>f?', function()
      -- prompt
      local cwd_s = vim.fn.input 'Path (./): '
      local hidden_c = vim.fn.input 'With hidden files? (Y/n) '
      local no_ignore_c = vim.fn.input 'Show files listed in .gitignore (node_modules)? (y/N) '
      -- check and assign
      current_cwd = cwd_s ~= '' and cwd_s or nil
      current_hidden = (hidden_c == 'n' or hidden_c == 'N') and false or true
      current_noignore = (no_ignore_c == 'y' or no_ignore_c == 'Y') and true or false

      builtin.fd {
        cwd = current_cwd,
        hidden = current_hidden,
        no_ignore = current_noignore,
      }
    end, { desc = '[F]ind [?] Path' })

    -- find from local variables
    map('n', '<leader>fR', function()
      builtin.fd {
        cwd = current_cwd,
        hidden = current_hidden,
        no_ignore = current_noignore,
      }
    end, { desc = '[F]ind [R]esume [?] Path' })
  end,
}
