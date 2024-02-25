return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
        ensure_installed = { 'lua', 'c', 'clojure' },
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
}
