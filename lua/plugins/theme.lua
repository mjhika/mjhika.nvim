return {
  {
    'mcchrish/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
    -- config = function()
    --   vim.cmd.colorscheme 'zenbones'
    -- end,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'oxocarbon'
    -- end,
  },
  {
    'miikanissi/modus-themes.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'modus_operandi'
    end,
  },
}
