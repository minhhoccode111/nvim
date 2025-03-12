-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`

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
          -- i = { ['<c-enter>'] = 'to_fuzzy_refine' },

          -- In case we prefer <tab> for completion
          -- i = { ['<tab>'] = require('telescope.actions').select_default },
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
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'ui-select'
    require('telescope').load_extension 'rest'
    -- require('telescope').load_extension 'flutter'

    -- See `:help telescope.builtin`
    -- mine
    local builtin = require 'telescope.builtin'
    local map = vim.keymap.set
    map('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    map('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    map('n', '<leader>ff', builtin.fd, { desc = '[F]ind [F]iles' })
    map('n', '<leader>fS', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    map('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind Current [W]ord' })
    map('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [G]rep String' })
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
        -- grep_open_files = true,
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

    -- -- Shortcut for searching my /cs dir
    -- map('n', '<leader>fC', function()
    --   builtin.fd { cwd = '~/cs', hidden = true, no_ignore = true }
    -- end, { desc = '[F]ind [C]S dir' })

    -- -- Shortcut for searching my /web dir
    -- map('n', '<leader>fW', function()
    --   builtin.fd { cwd = '~/web', hidden = true, no_ignore = false } -- so many node_modules
    -- end, { desc = '[F]ind /[w]eb dir' })

    -- -- Shortcut for searching my /learn dir
    -- map('n', '<leader>fL', function()
    --   builtin.fd { cwd = '~/learn', hidden = true, no_ignore = true }
    -- end, { desc = '[F]ind /[l]earn dir' })

    -- -- Shortcut for searching my /project dir
    -- map('n', '<leader>fP', function()
    --   builtin.fd { cwd = '~/project', hidden = true, no_ignore = false } -- so many node_modules
    -- end, { desc = '[F]ind /[p]roject dir' })

    -- -- Shortcut for searching my /Documents/current-obsidian dir
    -- map('n', '<leader>fO', function()
    --   builtin.fd { cwd = '~/Documents/current-obsidian/', hidden = true, no_ignore = true }
    -- end, { desc = '[F]ind [o]bsidian dir' })

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
