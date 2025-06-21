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
    'theHamsta/nvim-dap-virtual-text',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go', -- golang
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      '<F5>',
      function()
        require('dap').continue()
      end,
      desc = '[D]ebug: Start/Continue',
    },
    {
      '<leader>ds',
      function()
        require('dap').continue()
      end,
      desc = '[D]ebug: [S]tart/Continue',
    },
    {
      '<leader>dx',
      function()
        require('dap').terminate()
      end,
      desc = '[D]ebug: e[X]it',
    },
    {
      '<F1>',
      function()
        require('dap').step_into()
      end,
      desc = '[D]ebug: Step Into',
    },
    {
      '<F2>',
      function()
        require('dap').step_over()
      end,
      desc = '[D]ebug: Step Over',
    },
    {
      '<F3>',
      function()
        require('dap').step_out()
      end,
      desc = '[D]ebug: Step Out',
    },
    {
      '<F4>',
      function()
        require('dap').step_back()
      end,
      desc = '[D]ebug: Step Back',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = '[D]ebug: Toggle [B]reakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = '[D]ebug: Set [B]reakpoint',
    },
    {
      '<leader>dc',
      function()
        require('dap').run_to_cursor()
      end,
      desc = '[D]ebug: run to [C]ursor',
    },
    {
      '<leader>d?',
      function()
        ---@diagnostic disable-next-line: missing-fields
        require('dapui').eval(nil, { enter = true })
      end,
      desc = '[D]ebug: [?]Inspect current value',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      '<leader>dr',
      function()
        require('dapui').toggle()
      end,
      desc = '[D]ebug: See last session [r]esult',
    },
    -- TODO: move this to a dedicated file for Golang things :)
    {
      '<leader>dt',
      function()
        require('dap-go').debug_test()
      end,
      desc = '[D]ebug: [T]est Go',
    },
    {
      '<leader>dl',
      function()
        require('dap-go').debug_last_test()
      end,
      desc = '[D]ebug: [L]ast Test Go',
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    ---@diagnostic disable-next-line: missing-fields
    require('nvim-dap-virtual-text').setup {}

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

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
              size = 0.35,
            },
            {
              id = 'watches',
              size = 0.30,
            },
            {
              id = 'stacks',
              size = 0.25,
            },
            {
              id = 'breakpoints',
              size = 0.10,
            },
          },
          position = 'left',
          size = 0.45,
        },
        {
          elements = {
            {
              id = 'repl',
              size = 0.65,
            },
            {
              id = 'console',
              size = 0.35,
            },
          },
          position = 'bottom',
          size = 0.3,
        },
      },
      mappings = {
        edit = 'e', -- Edit a selected item (like variable or stack)
        expand = { '<CR>', '<2-LeftMouse>' }, -- Expand a collapsed item (use Enter or double-click)
        open = 'o', -- Open a selected item (like file or scope)
        remove = 'd', -- Remove a selected item (like breakpoint)
        repl = 'r', -- Open the REPL to evaluate expressions
        toggle = 't', -- Toggle visibility or state of a DAP UI item
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close
    -- dap.listeners.before.attach.dapui_config = dapui.open
    -- dap.listeners.before.launch.dapui_config = dapui.open
    -- dap.listeners.before.event_terminated.dapui_config = dapui.close
    -- dap.listeners.before.event_exited.dapui_config = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
  end,
}
