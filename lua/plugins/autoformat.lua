return {
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
}
