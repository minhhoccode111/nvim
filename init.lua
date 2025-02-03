--[[

===============================================================================
========================= READ THIS BEFORE CONTINUING =========================
===============================================================================
=============                                    .-----.          =============
=============         .----------------------.   | === |          =============
=============         |.-""""""""""""""""""-.|   |-----|          =============
=============         ||                    ||   | === |          =============
=============         ||   KICKSTART.NVIM   ||   |-----|          =============
=============         ||                    ||   | === |          =============
=============         ||                    ||   |-----|          =============
=============         ||:Tutor              ||   |:::::|          =============
=============         |'-..................-'|   |____o|          =============
=============         `"")----------------(""`   ___________      =============
=============        /::::::::::|  |::::::::::\  \ no mouse \     =============
=============       /:::========|  |==hjkl==:::\  \ required \    =============
=============      '""""""""""""'  '""""""""""""'  '""""""""""'   =============
=============                                                     =============
===============================================================================
===============================================================================

--]]

-- [[ Install `lazy.nvim` plugin manager ]]
-- See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

--  To check the current status of your plugins, run
--    :Lazy
--  To update plugins you can run
--    :Lazy update

require('lazy').setup(require 'mhc')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
