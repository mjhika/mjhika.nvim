return {
  {
    'deris/vim-shot-f',
    lazy = false,
  },

  {
    'jiaoshijie/undotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('undotree').setup()
      vim.keymap.set('n', '<leader>u', '<cmd>lua require("undotree").toggle()<cr>', { desc = 'Undo Tree' })
    end,
    -- keys = { -- load the plugin only when using it's keybinding:
    --   { '<leader>u', "<cmd>lua require('undotree').toggle()<cr>" },
    -- },
  },
}
