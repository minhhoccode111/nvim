-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go', -- golang
    -- 'NicholasMata/nvim-dap-cs', -- csharp
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      automatic_installation = false,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve', -- golang
      },
    }

    local map = vim.keymap.set
    -- Basic debugging keymaps, feel free to change to your liking!
    map('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    map('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    map('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    map('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    map('n', '<F4>', dap.step_out, { desc = 'Debug: Step Back' })
    map('n', '<leader>Db', dap.toggle_breakpoint, { desc = '[D]ebug: [B]reakpoint Toggle' })
    map('n', '<leader>DB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ebug: [B]reakpoint Set' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          disconnect = '',
          pause = '',
          play = '',
          run_last = '',
          step_back = '',
          step_into = '',
          step_out = '',
          step_over = '',
          terminate = '',
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = '',
        current_frame = '',
        expanded = '',
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.25,
              -- size = 1.0,
            },
            {
              id = 'breakpoints',
              size = 0.25,
              -- size = 0.05,
            },
            {
              id = 'stacks',
              size = 0.25,
              -- size = 0.05,
            },
            {
              id = 'watches',
              size = 0.25,
              -- size = 0.05,
            },
          },
          position = 'left',
          size = 40,
          -- size = 0.5,
        },
        {
          elements = { {
            id = 'repl',
            size = 0.5,
          }, {
            id = 'console',
            size = 0.5,
          } },
          position = 'bottom',
          size = 10,
          -- size = 0.1,
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    map('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- dap.defaults.fallback.terminal_win_cmd = '50vsplit new'
    -- dap.defaults.fallback.focus_terminal = true
    -- dap.defaults.fallback.external_terminal = {
    --   command = '/usr/bin/alacritty',
    --   args = { '-e' },
    -- }
    -- dap.defaults.fallback.force_external_terminal = true

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }

    -- require('dap-cs').setup {}

    -- Install csharp specific config
    -- require('dap-cs').setup {
    --   -- Additional dap configurations can be added.
    --   -- dap_configurations accepts a list of tables where each entry
    --   -- represents a dap configuration. For more details do:
    --   -- :help dap-configuration
    --   dap_configurations = {
    --     {
    --       -- Must be "coreclr" or it will be ignored by the plugin
    --       type = 'coreclr',
    --       name = 'Attach remote',
    --       mode = 'remote',
    --       request = 'attach',
    --       console = 'integratedTerminal', -- use DAP console for program I/O
    --       -- console = 'externalTerminal', -- use DAP console for program I/O
    --       -- console = 'internalConsole', -- use DAP console for program I/O
    --     },
    --   },
    --   netcoredbg = {
    --     -- the path to the executable netcoredbg which will be used for debugging.
    --     -- by default, this is the "netcoredbg" executable on your PATH.
    --     -- path = 'NETCOREDBG',
    --     path = 'netcoredbg',
    --   },
    -- }
  end,
}
