require 'opts'
require 'keys'
require 'ui'

-- Install package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- configure plugins in the following
require('lazy').setup({

  -- most taken straight from kickstart
  require 'plugins.whitespace',
  require 'plugins.comment',
  require 'plugins.autoformat',
  require 'plugins.which',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocomplete',
  require 'plugins.mini',
  require 'plugins.treesitter',
  require 'plugins.markdown',

  -- mostly my own choices
  require 'plugins.theme',
  require 'plugins.navigation',
  require 'plugins.autopairs',
  require 'plugins.git',
  require 'plugins.lisp',
  require 'plugins.go',
  require 'plugins.zig',

  -- older kickstart ones keeping for referenc
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
