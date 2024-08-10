return {
  {
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
            'target', --https://www.lua.org/pil/20.2.html
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
}
