-- improve default vim.ui interfaces

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true }, -- disable expensive features on large files
    quickfile = { enabled = true }, -- fast file rendering before plugins load
    scroll = { enabled = true }, -- smooth scrolling / scrollbar animator
    -- input = { enabled = true },       -- prettier vim.ui.input prompts
    -- notifier = { enabled = true },    -- pretty vim.notify messages
    -- statuscolumn = { enabled = true },-- richer fold/sign/line-number column
    -- animate  = { enabled = true },    -- easing animations (library)
    -- bufdelete = { enabled = true },   -- buffer delete without breaking layout
    -- dashboard = { enabled = true },   -- startup dashboard screen
    -- debug    = { enabled = true },    -- pretty inspect & backtraces
    -- dim      = { enabled = true },    -- dim code outside active scope
    -- explorer  = { enabled = true },   -- file explorer (picker-based)
    -- gh       = { enabled = true },    -- GitHub CLI integration
    -- git      = { enabled = true },    -- git utilities (blame, etc.)
    -- gitbrowse = { enabled = true },   -- open repo/file in browser
    -- image    = { enabled = true },    -- render images (kitty/wezterm/ghostty)
    -- indent    = { enabled = true },   -- indent guides (replace indent-blankline)
    -- layout   = { enabled = true },    -- window layout management
    -- lazygit  = { enabled = true },    -- lazygit in a floating window
    -- picker   = { enabled = true },    -- fuzzy finder (like Telescope)
    -- profiler = { enabled = true },    -- Lua profiler for Neovim
    -- rename   = { enabled = true },    -- LSP-integrated file renaming
    -- scope    = { enabled = true },    -- treesitter/indent-based scope detection
    -- scratch  = { enabled = true },    -- scratch buffers with persistence
    -- terminal = { enabled = true },    -- toggle floating/split terminals
    -- toggle   = { enabled = true },    -- toggle keymaps with which-key icons
    -- words    = { enabled = true },    -- highlight cursor word + LSP references
    -- zen      = { enabled = true },    -- distraction-free zen mode
  },
}
