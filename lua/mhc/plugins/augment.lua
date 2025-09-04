return {
  'augmentcode/augment.vim',

  -- Ensure Node.js dependency is available
  cond = function()
    return vim.fn.executable 'node' == 1
  end,

  -- Plugin configuration
  config = function()
    -- Set workspace folders (modify these paths as needed)
    -- These should be paths relative to home (~) or absolute paths
    vim.g.augment_workspace_folders = {
      -- Add your project paths here, examples:
      -- '~/projects/budibase',
      -- '~/work/moodleapp-hisoft',
    }

    -- Optional: Disable default tab mapping if you prefer custom mappings
    -- vim.g.augment_disable_tab_mapping = true

    -- Optional: Disable completions entirely if you only want chat
    -- vim.g.augment_disable_completions = true
  end,

  -- Key mappings
  keys = {
    -- New chat conversation
    {
      '<leader>AN',
      '<cmd>Augment chat-new<CR>',
      desc = '[A]ction: Augment: [N]ew chat conversation',
      mode = { 'n', 'v' },
    },

    -- Toggle chat panel
    {
      '<leader>AT',
      '<cmd>Augment chat-toggle<CR>',
      desc = '[A]ction: Augment: [T]oggle chat panel',
      mode = 'n',
    },

    -- Ask for workspace folders (opens input prompt)
    {
      '<leader>AW',
      function()
        -- Prompt user for workspace folder path (relative to home)
        local input = vim.fn.input 'Enter workspace path (relative to ~): ~/'
        if input and input ~= '' then
          -- Construct full path
          local full_path = '~/' .. input

          -- Get current workspace folders or initialize empty table
          local current_folders = vim.g.augment_workspace_folders or {}

          -- Add new folder if not already present
          local found = false
          for _, folder in ipairs(current_folders) do
            if folder == full_path then
              found = true
              break
            end
          end

          if not found then
            table.insert(current_folders, full_path)
            vim.g.augment_workspace_folders = current_folders
            print('Added workspace folder: ' .. full_path)
            print 'Restart Neovim for changes to take effect.'
          else
            print('Workspace folder already exists: ' .. full_path)
          end
        end
      end,
      desc = '[A]ction: Augment: Add [W]orkspace folder',
      mode = 'n',
    },

    -- Additional useful mappings
    --   {
    --     '<leader>As',
    --     '<cmd>Augment status<CR>',
    --     desc = 'Augment: Show status',
    --     mode = 'n',
    --   },
    --
    {
      '<leader>C',
      function()
        local message = vim.fn.input 'Chat message: '
        if message and message ~= '' then
          vim.cmd('Augment chat ' .. message)
        end
      end,
      desc = 'Augment: Send a chat message in the current conversation',
      mode = 'n',
    },
    --
    --   -- Chat with selected text in visual mode
    --   {
    --     '<leader>Ac',
    --     ':Augment chat ',
    --     desc = 'Augment: Chat about selection',
    --     mode = 'v',
    --   },
    --
    --   {
    --     '<leader>Al',
    --     '<cmd>Augment log<CR>',
    --     desc = 'Augment: Show log',
    --     mode = 'n',
    --   },
    --
    --   -- Sign in/out commands
    --   {
    --     '<leader>Ai',
    --     '<cmd>Augment signin<CR>',
    --     desc = 'Augment: Sign in',
    --     mode = 'n',
    --   },
    --
    --   {
    --     '<leader>Ao',
    --     '<cmd>Augment signout<CR>',
    --     desc = 'Augment: Sign out',
    --     mode = 'n',
    --   },
    -- },

    -- Lazy load on first command or keymap
    cmd = {
      'Augment',
    },

    -- Plugin dependencies and setup info
    dependencies = {
      -- Note: Node.js 22.0.0+ is required as external dependency
    },
  },
}
