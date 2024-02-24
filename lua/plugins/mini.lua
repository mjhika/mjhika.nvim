return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 } -- Better Around/Inside textobjects
      require('mini.surround').setup() -- Add/delete/replace surroundings (brackets, quotes, etc.)
      require('mini.statusline').setup() -- Simple and easy statusline.
    end,
  },
}
