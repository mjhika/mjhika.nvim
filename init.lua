-- [[ Setting options ]]
vim.g.mapleader = ' ' -- bindings for global
vim.g.maplocalleader = ',' -- bindings for local
vim.opt.hlsearch = true
vim.opt.colorcolumn = '80,120' -- column width
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true -- relative numbers
vim.opt.mouse = 'a' -- enable mouse
vim.opt.breakindent = true
vim.opt.undofile = true -- Save undo history
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.inccommand = 'split' -- preview the things you are changing using substitution
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes' -- signcolumn to the left of the numbers
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.completeopt = 'menuone,noselect' -- a better completion experience
vim.opt.termguicolors = true -- all the colors
vim.opt.tabstop = 2 -- Set whitespace to be 2 always
vim.opt.shiftwidth = 2 -- Set whitespace to be 2 always
vim.opt.softtabstop = 2 -- Set whitespace to be 2 always
vim.opt.expandtab = true -- spaces are better than tabs
vim.opt.splitbelow = true -- open splits on the bottom
vim.opt.splitright = true -- open splits on the right
vim.opt.timeout = true -- timeout for which-key
vim.opt.timeoutlen = 350 -- timeout for which-key
vim.opt.showmode = false -- disable echoing the mode in favor of the status line
vim.opt.list = true -- formatting for some whitespace
vim.opt.listchars = 'tab:⇥ ,eol:λ,nbsp:⋅,trail:∘' -- the whitespace replacements
vim.opt.background = 'dark' -- a dark background for this theme

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) -- silence the normal <Space>
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up half page' }) -- center while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down half page' }) -- center while scrolling
vim.keymap.set('n', '<C-j>', ':bnext<CR>', { desc = 'Next Buffer', silent = true }) -- easily change buffers
vim.keymap.set('n', '<C-k>', ':bprev<CR>', { desc = 'Previous Buffer', silent = true }) -- easily change buffers
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = 'Close Buffer', silent = true }) -- close buffer
vim.keymap.set('n', '<leader>C', ':bdelete!<CR>', { desc = 'Force Close Buffer', silent = true }) -- close buffer really
vim.cmd [[ nnoremap <silent> <expr> <CR> {-> v:hlsearch ? "<cmd>nohl\<CR>" : "\<CR>"}() ]] -- clear the highlighted search with <CR>
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true }) -- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true }) -- Remap for dealing with word wrap
vim.keymap.set('t', '<C-c><C-c>', '<C-\\><C-n>', { desc = 'Escape Escape from the terminal' }) -- make escaping the terminal easier
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected line down' }) -- easier select moving
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected line up' }) -- easier select moving

vim.keymap.set('n', '<leader>tt', function() -- make a terminal appear
  vim.cmd.split()
  vim.cmd.terminal()
  vim.cmd 'startinsert'
end, { desc = '[T]oggle [t]erm' })

vim.keymap.set('n', '<leader>tm', function() -- toggle MarkdownPreviewToggle
  vim.cmd 'MarkdownPreviewToggle'
end, { desc = '[T]oggle [M]arkdown Preview' })

-- [[ Diagnostic keymaps ]]
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

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
  -- included so that a minimal setup can be made from just the 1 file
  {
    'nvim-lualine/lualine.nvim',
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'auto',
    },
  },

  {
    'savq/melange-nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'melange'
    end,
  },

  {
    'deris/vim-shot-f',
    lazy = false,
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    -- dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'm4xshen/hardtime.nvim',
    dependencies = { 'MunifTanjim/nui.nvim', 'nvim-lua/plenary.nvim' },
    opts = {},
    disabled_filetypes = { 'qf', 'netrw', 'NvimTree', 'lazy', 'mason', 'oil' },
  },

  {
    'jiaoshijie/undotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('undotree').setup()
      vim.keymap.set('n', '<leader>u', '<cmd>lua require("undotree").toggle()<cr>', { desc = '[U]ndo Tree' })
    end,
  },
  -- require 'plugins.autopairs',
  -- require 'plugins.whitespace',
  -- require 'plugins.comment',
  -- require 'plugins.which',
  -- require 'plugins.mini',
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        ensure_installed = { 'lua', 'c', 'clojure', 'go' },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = '<c-s>',
            node_decremental = '<M-space>',
          },
        },
      }
    end,
  },

  -- require 'plugins.autoformat',
  -- require 'plugins.telescope',
  -- require 'plugins.lsp',
  -- require 'plugins.autocomplete',

  -- require 'plugins.git',
  -- require 'plugins.lisp',
  -- require 'plugins.go',
  -- require 'plugins.zig',
  -- require 'plugins.markdown',

  { import = 'plugins' },

  -- older kickstart ones keeping for referenc
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
