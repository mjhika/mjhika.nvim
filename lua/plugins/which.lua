return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()

      -- document existing key chains
      require('which-key').register {
        ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      }
    end,
  },
}
