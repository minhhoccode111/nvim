local map = vim.keymap.set
local nomap = vim.keymap.del

--[[ KEYS ]]

-- Enter Normal mode from Insert mode
map('i', 'jj', '<esc>', { desc = 'Enter Normal mode from Insert mode' })

-- gj, gk instead of j, k. Turn off since not set line wrap
-- map({ 'n', 'v' }, 'j', 'gj', { desc = 'Move sub line' })
-- map({ 'n', 'v' }, 'k', 'gk', { desc = 'Move sub line' })

-- Visual mode JK to mode selected text
-- Copy from The Prime Agen, work like magic
map('v', '<a-j>', ":m '>+1<CR>gv=gv", { desc = 'Hold Alt Move Line' })
map('v', '<a-k>', ":m '<-2<CR>gv=gv", { desc = 'Hold Alt Move Line' })
-- Normal mode auto enter visual and exit after getting things done
map('n', '<a-j>', "V:m '>+1<CR>gv=gv<esc>", { desc = 'Hold Alt Move Line' })
map('n', '<a-k>', "V:m '<-2<CR>gv=gv<esc>", { desc = 'Hold Alt Move Line' })

-- Join line below but keep cursor position the same
map('n', 'J', 'mzJ`z', { desc = 'Join line below and keep cursor position the same' })

-- Center cursor after moving screen
map('n', 'n', 'nzzzv', { desc = 'Center cursor after moving screen' })
map('n', 'N', 'Nzzzv', { desc = 'Center cursor after moving screen' })
-- map('n', '<c-f>', '<c-f>zz', { desc = 'Center cursor after moving screen' })
-- map('n', '<c-b>', '<c-b>zz', { desc = 'Center cursor after moving screen' })
-- map('n', '<c-d>', '<c-d>zz', { desc = 'Center cursor after moving screen' })
-- map('n', '<c-u>', '<c-u>zz', { desc = 'Center cursor after moving screen' })
-- map('n', '}', '}zz', { desc = 'Center cursor after moving screen' })
-- map('n', '{', '{zz', { desc = 'Center cursor after moving screen' })
-- map('n', '(', '(zz', { desc = 'Center cursor after moving screen' })
-- map('n', ')', ')zz', { desc = 'Center cursor after moving screen' })

-- Basic movement and jumping
map({ 'n', 'o', 'v' }, 'H', '^', { desc = 'Jump to start of line' })
map({ 'n', 'o', 'v' }, 'L', '$', { desc = 'Jump to end of line' })
-- no Visual since it is used to move line up and down
map({ 'n', 'o', 'v' }, 'K', '%', { desc = 'Jump between braces' })

-- Insert new line above and stay in Normal mode
map('n', 'O', 'o<esc>', { desc = 'New line above' })

-- Insert new line and move cursor down in Insert mode
-- map('i', '<c-j>', '<esc>o', { desc = 'New line in Insert mode' })

-- Select all with <C-a>
map({ 'i', 'n', 'v' }, '<C-a>', '<esc>ggVG', { desc = 'Select all' })

-- Paste over selected text without losing current clipboard
map('x', '<leader>p', '"_dP', { desc = 'Paste without losing clipboard' })

-- Keybinds to make split navigation easier.
-- Use ALT+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
-- NOTE: not in use because we use tmux-navigator already
-- map('n', '<c-h>', '<c-w><c-h>', { desc = 'Move focus to the left window' })
-- map('n', '<c-l>', '<c-w><c-l>', { desc = 'Move focus to the right window' })
-- map('n', '<c-j>', '<c-w><c-j>', { desc = 'Move focus to the lower window' })
-- map('n', '<c-k>', '<c-w><c-k>', { desc = 'Move focus to the upper window' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- <esc><esc>
map('t', 'jj', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- better default
-- map('c', '%s/', '%sm/', { desc = 'Default magic regex' })
-- map('n', '/', '/\\v', { desc = 'Default magic regex' })
-- map('n', '?', '?\\v', { desc = 'Default magic regex' })

--[[ COMMANDS ]]

-- Save file with <C-s>
map({ 'i', 'n' }, '<C-s>', '<cmd> w <cr>', { desc = 'Save file' })

-- Replace regex string current file
map('n', '<leader>rr', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = '[R]eplace [R]egex String' })
-- Replace variable name using inc-rename.nvim
-- map('n', '<leader>rn', ':IncRename ', { desc = '[R]eplace Var [N]ame' })
map('n', '<leader>rn', function()
  return ':IncRename ' .. vim.fn.expand '<cword>'
end, { expr = true, desc = '[R]eplace Var [N]ame' })

-- Source current file
map('n', '<leader>S', '<cmd>so<cr>', { desc = '[S]ource File' })

-- Toggle small things -- `!` stand for toggle action
map('n', '<leader>tn', '<cmd>set nu!<cr>', { desc = '[T]oggle [N]umber Line' })
map('n', '<leader>tr', '<cmd>set rnu!<cr>', { desc = '[T]oggle [R]elative Number Line' })
map('n', '<leader>tw', '<cmd>set wrap!<cr>', { desc = '[T]oggle [W]rap Line' })
map('n', '<leader>td', function()
  -- to toggle
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = '[T]oggle [D]iagnostic Warning' })

-- toggle gj, gk movement
local isMovementEnabled = false
map('n', '<leader>tm', function()
  if isMovementEnabled then
    isMovementEnabled = false
    nomap({ 'n', 'v' }, 'j', { desc = 'Disable keymap for j' })
    nomap({ 'n', 'v' }, 'k', { desc = 'Disable keymap for k' })
  else
    isMovementEnabled = true
    map({ 'n', 'v' }, 'j', 'gj', { desc = 'Enable keymap for j' })
    map({ 'n', 'v' }, 'k', 'gk', { desc = 'Enable keymap for k' })
  end
end, { desc = '[T]oggle [M]ovement gj, gk' })

-- Close window
map('n', '<leader>xx', '<cmd> q <cr>', { desc = '[X]Close w/ :q' })
map('n', '<leader>xa', '<cmd> qa <cr>', { desc = '[X]Close w/ :q[a]' })

-- Change window Width
map('n', '<a-,>', '<c-w><', { desc = 'Decrease Window Width' })
map('n', '<a-.>', '<c-w>>', { desc = 'Increase Window Width' })

-- Change window Height
map('n', '<a-->', '<c-w>-', { desc = 'Decrease Window Height' })
map('n', '<a-=>', '<c-w>+', { desc = 'Increase Window Height' })

-- Split window
map('n', '<leader>_', '<cmd> sp <cr>', { desc = '[_] Horizon Window' })
map('n', '<leader>|', '<cmd> vsp <cr>', { desc = '[|] Vertical Window' })

-- Extra terminal keymaps in term.lua
-- Extra markdown keymaps in markdownpreview.lua
-- Extra rest nvim keymaps in rest.lua

-- Cycle through files in current buffer
map('n', '<c-o>', '<cmd> bn <cr>', { desc = 'Next Buffer', silent = true })
map('n', '<c-i>', '<cmd> bp <cr>', { desc = 'Prev Buffer', silent = true })
-- the default ones but use Alt because i rarely use it, and for me `i` is back and `o` is forth
-- map('n', '<A-[>', '<C-o>', { desc = 'Go to older position in jump list' })
-- map('n', '<A-]>', '<C-i>', { desc = 'Go to newer position in jump list' })
map('n', '<A-p>', '<C-o>', { desc = 'Go to previous position in jump list' })
map('n', '<A-n>', '<C-i>', { desc = 'Go to next position in jump list' })

-- Close current buffer
map('n', '<leader>xb', '<cmd> bd <cr>', { desc = '[X]Close w/ :[b]d', silent = true })
-- NOTE: move to bufferline plugin specific
-- Pick buffer to close
-- map('n', '<leader>xp', '<cmd>lua require("bufferline").close_with_pick()<cr>', { desc = '[X]Close [P]ick Buffer' })
-- Close other buffers (bufferline plugin)
-- map('n', '<leader>xo', '<cmd> BufferLineCloseOthers <cr>', { desc = '[X]Close [O]ther Buffers', silent = true })

-- Diagnostic keymaps
map('n', '<leader>k', vim.diagnostic.goto_prev, { desc = '[D]iagnostic [k]Previous message' })
map('n', '<leader>j', vim.diagnostic.goto_next, { desc = '[D]iagnostic [j]Next message' })
-- map('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = '[D]iagnostic [P]revious message' })
-- map('n', '<leader>dn', vim.diagnostic.goto_next, { desc = '[D]iagnostic [N]ext message' })
map('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = '[D]iagnostic [k]Previous message' })
map('n', '<leader>dj', vim.diagnostic.goto_next, { desc = '[D]iagnostic [j]Next message' })
map('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Show [D]iagnostic [E]rror messages' })
map('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic [Q]uickfix list' })

-- Managers
map('n', '<leader>mm', '<cmd>Mason<cr>', { desc = '[M]anager [M]ason' })
map('n', '<leader>ml', '<cmd>Lazy<cr>', { desc = '[M]anager [L]azy' })
map('n', '<leader>mh', '<cmd>checkhealth<cr>', { desc = '[M]anager check [H]ealth' })
map('n', '<leader>ms', '<cmd>lua require"telescope.builtin".colorscheme()<cr>', { desc = '[M]anager Select [S]cheme' })

return {}
