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

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
