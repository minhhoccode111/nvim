return {
  'nvim-neo-tree/neo-tree.nvim',

  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- [[ Expand all, but not the hidden/ignored directories ]]
    --
    -- neo-tree's built-in `expand_all_nodes` recurses into every directory node
    -- that is rendered in the tree, which includes directories that are only
    -- visible because of `filtered_items.always_show` (e.g. `.github` below).
    -- Anything neo-tree hides -- dotfiles, gitignored paths, `hide_by_name`,
    -- `never_show` -- is filtered out of the tree entirely and is never
    -- touched.
    --
    -- Fix: hand neo-tree's own expander a prefetcher that refuses to descend
    -- into nodes carrying `filtered_by` (neo-tree's marker for "hidden or
    -- ignored"). Children of a skipped directory inherit that marker, so they
    -- are skipped as well. Everything else behaves exactly like 'A' did.
    --
    -- Note: `.github` now stays collapsed. To get the old behaviour back, map
    -- 'A' to 'expand_all_nodes' again.
    --
    -- Known gap: a hidden/ignored directory nested *inside* a visible directory
    -- can still end up expanded when `filtered_items.visible = true`, because
    -- neo-tree loads a subtree in one recursive scan and expands any node whose
    -- children arrive. With the default `visible = false` those directories are
    -- never rendered, so the gap is invisible.
    local expand_visible_dirs = function(state)
      local fs = require 'neo-tree.sources.filesystem'

      ---@param node NuiTree.Node
      local is_hidden_or_ignored = function(node)
        return node.filtered_by ~= nil
      end

      local prefetcher = {
        prefetch = function(prefetch_state, node)
          -- Never scan a hidden/ignored directory: scanning it would pull its
          -- children into the tree.
          if is_hidden_or_ignored(node) then
            return
          end
          fs.prefetcher.prefetch(prefetch_state, node)
        end,
        should_prefetch = function(node)
          -- Returning true here makes the expander defer the node instead of
          -- expanding it, which is exactly what we want for hidden/ignored
          -- directories, loaded or not.
          if is_hidden_or_ignored(node) then
            return true
          end
          return fs.prefetcher.should_prefetch(node)
        end,
      }

      require('neo-tree.sources.common.commands').expand_all_nodes(state, nil, prefetcher)
    end

    require('neo-tree').setup {
      event_handlers = {
        {
          event = 'neo_tree_buffer_enter',
          handler = function()
            vim.cmd [[
          setlocal relativenumber
        ]]
          end,
        },
      },
      filesystem = {
        filtered_items = {
          -- hide_dotfiles = false,
          -- hide_gitignored = false,
          never_show = {
            '.git',
            'node_modules',
          },
          always_show = { -- remains visible even if other settings would normally hide it
            '.gitignore',
            '.github',
            '.env',
            '.env.test',
            '.env.production',
            '.env.development',
            '.env.local',
            '.env.dev',
            '.env.prod',
            '.env.example',
          },
        },
        window = {
          mappings = {
            ['l'] = 'set_root',
            ['h'] = 'navigate_up',

            ['_'] = 'open_split',
            ['|'] = 'open_vsplit',

            ['Q'] = 'close_all_nodes',
            ['A'] = expand_visible_dirs, -- expand all, except hidden/ignored dirs (see above)

            -- ['H'] = 'toggle_hidden',
            ['L'] = 'focus_preview',
            ['w'] = 'open',

            ['/'] = 'none', -- to quick jumping with /
            ['z'] = 'none', -- since we want to center screen
            -- ['o'] = 'open',
            -- ['oc'] = 'none',
            -- ['od'] = 'none',
            -- ['og'] = 'none',
            -- ['om'] = 'none',
            -- ['on'] = 'none',
            -- ['os'] = 'none',
            -- ['ot'] = 'none',
          },
        },
      },
    }

    local map = vim.keymap.set

    map('n', '<c-n>', '<cmd> Neotree toggle float<cr>', { desc = '[N]eotree [F]loat' })
    map('n', '<leader>nf', '<cmd> Neotree toggle float<cr>', { desc = '[N]eotree [F]loat' })
    map('n', '<leader>nl', '<cmd> Neotree toggle left <cr>', { desc = '[N]eotree [L]eft' })
    map('n', '<leader>nr', '<cmd> Neotree toggle right <cr>', { desc = '[N]eotree [R]ight' })
    map('n', '<leader>nc', '<cmd> Neotree reveal <cr>', { desc = '[N]eotree Reveal [C]urrent File' })
  end,
}
