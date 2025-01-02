-- [[ Setting options ]]
vim.g.mapleader = ' '          -- bindings for global
vim.g.maplocalleader = ','     -- bindings for local
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
vim.opt.listchars = 'tab:⇥ ,eol:⏎,nbsp:⋅,trail:∘' -- the whitespace replacements
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })                               -- silence the normal <Space>
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move up half page' })                           -- center while scrolling
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move down half page' })                         -- center while scrolling
vim.keymap.set('n', '<C-j>', ':bnext<CR>', { desc = 'Next Buffer', silent = true })               -- easily change buffers
vim.keymap.set('n', '<C-k>', ':bprev<CR>', { desc = 'Previous Buffer', silent = true })           -- easily change buffers
vim.keymap.set('n', '<leader>c', ':bdelete<CR>', { desc = 'Close Buffer', silent = true })        -- close buffer
vim.keymap.set('n', '<leader>C', ':bdelete!<CR>', { desc = 'Force Close Buffer', silent = true }) -- close buffer really
vim.cmd [[ nnoremap <silent> <expr> <CR> {-> v:hlsearch ? "<cmd>nohl\<CR>" : "\<CR>"}() ]]        -- clear the highlighted search with <CR>
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })             -- Remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })             -- Remap for dealing with word wrap
vim.keymap.set('t', '<C-c><C-c>', '<C-\\><C-n>', { desc = 'Escape Escape from the terminal' })    -- make escaping the terminal easier
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected line down' })                -- easier select moving
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected line up' })                  -- easier select moving

vim.keymap.set('n', '<leader>tt', function()                                                      -- make a terminal appear
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
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup {}

      vim.cmd.colorscheme 'github_light'
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
    'jiaoshijie/undotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('undotree').setup()
      vim.keymap.set('n', '<leader>u', '<cmd>lua require("undotree").toggle()<cr>', { desc = '[U]ndo Tree' })
    end,
  },

  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  { 'tpope/vim-sleuth' },

  { 'numToStr/Comment.nvim', opts = {} },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()

      -- document existing key chains
      require('which-key').add {
        { '<leader>d', group = '[D]iagnostics' },
        { '<leader>f', group = '[F]ind' },
        { '<leader>l', group = '[L]SP' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>g', group = '[G]it' },
      }
    end,
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Better Around/Inside textobjects
      require('mini.surround').setup()           -- Add/delete/replace surroundings (brackets, quotes, etc.)
    end,
  },

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

  { -- FindMy, but for files
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: `build` is used to run some command when the plugin is installed/updated.
        --  This is only run then, not every time Neovim starts up.
        build = 'make',

        -- NOTE: `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = {
            '%.git',
            'node_modules',
            '%.idea',
            'project/target', --https://www.lua.org/pil/20.2.html
            'target',         --https://www.lua.org/pil/20.2.html
            '%.cache',
            '%.cpcache',
            'cljs%-runtime',
          },
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'fzf')

      local builtin = require 'telescope.builtin'
      -- See `:help telescope.builtin`
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function() -- live grep open files
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[/] in Open Files' })

      vim.keymap.set('n', '<leader>fF', function() -- search files but include ignored files
        builtin.find_files {
          no_ignore = true,
        }
      end, { desc = '[F]ind [F]iles (no ignore)' })

      vim.keymap.set('n', '<leader>fn', function() -- Shortcut for searching your neovim configuration files
        builtin.find_files {
          cwd = vim.fn.stdpath 'config',
        }
      end, { desc = '[F]ind in [N]eovim files' })

      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymap' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader>fv', builtin.git_files, { desc = '[F]ind [V]ersion Control (git)' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind [g]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- 'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      require('neodev').setup()

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          -- Important LSP Navigation keybinds
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>lt', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>lsd', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>lsw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('<leader>lr', vim.lsp.buf.rename, '[L]SP [R]ename') -- Rename the variable under your cursor
          map('<leader>lc', function()
            vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
          end, '[L]SP [C]ode Action')
          map('<leader>K', vim.lsp.buf.hover, 'Hover Documentation')          -- See `:help K` for why this keymap
          map('<M-k>', vim.lsp.buf.signature_help, 'Signature Documentation') -- Show the signature of the function you're currently completing.
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        clangd = {},
        gopls = {},
        clojure_lsp = {},
        -- ocamllsp = {},
        zls = {},
        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
              },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- local ensure_installed = vim.tbl_keys(servers or {})
      -- vim.list_extend(ensure_installed, {
      --   -- 'stylua',
      --   -- 'ocamlformat',
      --   -- 'goimports',
      --   -- 'golangci-lint',
      -- })

      -- vim.list_extend(ensure_installed, vim.tbl_keys(servers))
      -- Ensure the servers above are installed
      require('mason').setup()
      -- require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            require('lspconfig')[server_name].setup {
              cmd = server.cmd,
              settings = server.settings,
              filetypes = server.filetypes,
              capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {}),
            }
          end,
        },
      }
    end,
  },

  -- autoformatting for files
  {
    'stevearc/conform.nvim',
    event = 'VeryLazy',
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        clojure = { 'cljfmt' },
        go = { 'gofmt', 'goimports' },
        c = { 'clang_format' },
      },
    },
  },

  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'
        vim.keymap.set('n', '<leader>gb', function()
          gitsigns.blame_line { full = true }
        end, { buffer = bufnr, desc = '[G]it [B]lame line' })
        vim.keymap.set('n', '<leader>gv', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[G]it Pre[v]iew hunk' })
      end,
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- add flair to the cmp suggestions
      'onsails/lspkind.nvim',

      -- other sources
      'hrsh7th/cmp-buffer',
      'PaterJason/cmp-conjure',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local luasnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(), -- Select the [n]ext item
          ['<C-p>'] = cmp.mapping.select_prev_item(), -- Select the [p]revious item
          ['<C-y>'] = cmp.mapping.confirm { select = true },
          ['<C-Space>'] = cmp.mapping.complete {},
          ['<C-l>'] = cmp.mapping(function() -- <c-l> will move you to the right of each of the expansion locations.
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function() -- <c-h> is similar, except moving you backwards.
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'conjure' },
          { name = 'path' },
          { name = 'buffer' },
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            menu = {
              buffer = '[Buffer]',
              conjure = '[Conjure]',
              nvim_lsp = '[LSP]',
              path = '[Path]',
              luasnip = '[LuaSnip]',
            },
          },
        },
      }
    end,
  },
  -- require 'plugins.autoformat',
  -- require 'plugins.lsp',
  -- require 'plugins.autocomplete',

  -- require 'plugins.git',
  -- require 'plugins.lisp',
  -- require 'plugins.go',
  -- require 'plugins.zig',
  -- require 'plugins.markdown',

  { import = 'plugins' },

  -- older kickstart ones keeping for reference
  -- require 'kickstart.plugins.debug',
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
