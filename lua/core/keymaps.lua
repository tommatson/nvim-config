-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable spacebar default
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Save file (Standard Neovim mappings)
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { silent = true, desc = 'Save File' })
vim.keymap.set({ 'n', 'i', 'v' }, '<C-s>', '<cmd>w<CR><esc>', { silent = true, desc = 'Save File' })

-- Keep cursor centred when jumping / searching
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down (centred)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up (centred)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search (centred)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search (centred)' })

-- Move lines up/down in visual mode (Standard custom enhancement)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Window navigation (Standard Vim controls)
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Go to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Go to lower window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Go to upper window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Go to right window' })

-- Resize splits with Alt+arrows
vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { silent = true, desc = 'Grow split height' })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { silent = true, desc = 'Shrink split height' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { silent = true, desc = 'Shrink split width' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { silent = true, desc = 'Grow split width' })

-- Quickfix navigation
vim.keymap.set('n', ']q', ':cnext<CR>zz', { silent = true, desc = 'Next quickfix' })
vim.keymap.set('n', '[q', ':cprev<CR>zz', { silent = true, desc = 'Prev quickfix' })

-- Diagnostic navigation
vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Prev diagnostic' })

-- Alphanumeric jumping with Shift+arrows (skips punctuation/symbols, ignores CamelCase)
local alphanumeric_pattern = [=[\v(^[^a-zA-Z0-9]*\zs[a-zA-Z0-9])|([^a-zA-Z0-9]\zs[a-zA-Z0-9])]=]

vim.keymap.set({ 'n', 'v' }, '<S-Right>', function()
  vim.fn.search(alphanumeric_pattern, 'W')
end, { desc = 'Jump right (Alphanumeric)' })

vim.keymap.set({ 'n', 'v' }, '<S-Left>', function()
  vim.fn.search(alphanumeric_pattern, 'bW')
end, { desc = 'Jump left (Alphanumeric)' })

vim.keymap.set('i', '<S-Right>', function()
  vim.cmd('normal! l')
  vim.fn.search(alphanumeric_pattern, 'W')
end, { desc = 'Jump right (Alphanumeric)' })

vim.keymap.set('i', '<S-Left>', function()
  vim.cmd('normal! h')
  vim.fn.search(alphanumeric_pattern, 'bW')
end, { desc = 'Jump left (Alphanumeric)' })
