-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable spacebar default
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- File tree
vim.keymap.set('n', '<leader>c', ':Neotree toggle<CR>', { silent = true, desc = 'Toggle Explorer' })

-- Save / quit
vim.keymap.set({ 'n', 'i' }, '<C-s>', '<cmd>w<CR>', { noremap = true, silent = true, desc = 'Save File' })
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', { noremap = true, silent = true, desc = 'Quit' })

-- Delete without yanking
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true })

-- Paste without overwriting register
vim.keymap.set('v', 'p', '"_dP', { noremap = true, silent = true })

-- Undo / redo (Ctrl+Z / Ctrl+G)
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = 'Undo' })
vim.keymap.set('n', '<C-g>', '<C-r>', { desc = 'Redo' })
vim.keymap.set('i', '<C-g>', '<C-o><C-r>', { desc = 'Redo' })

-- Paste from clipboard (bridge keybind)
vim.keymap.set('i', '<C-]>', '<C-r><C-p>+', { desc = 'Paste clipboard' })
vim.keymap.set('n', '<C-]>', '"+p', { desc = 'Paste clipboard' })

-- Line navigation
vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'End of line' })
vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = 'Start of line' })

-- Move lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep cursor centred when jumping
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down (centred)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up (centred)' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search (centred)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search (centred)' })

-- Window navigation with Ctrl+arrows (mouse-friendly)
vim.keymap.set('n', '<C-Left>', '<C-w>h', { desc = 'Window left' })
vim.keymap.set('n', '<C-Down>', '<C-w>j', { desc = 'Window down' })
vim.keymap.set('n', '<C-Up>', '<C-w>k', { desc = 'Window up' })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { desc = 'Window right' })

-- Resize splits with Alt+arrows
vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { silent = true, desc = 'Grow split height' })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { silent = true, desc = 'Shrink split height' })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { silent = true, desc = 'Shrink split width' })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { silent = true, desc = 'Grow split width' })

-- Quickfix navigation (handy for compiler erorrs)
vim.keymap.set('n', ']q', ':cnext<CR>zz', { silent = true, desc = 'Next quickfix' })
vim.keymap.set('n', '[q', ':cprev<CR>zz', { silent = true, desc = 'Prev quickfix' })

-- Diagnostic navigation
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })

-- CamelCase / symbol jumping with Shift+arrows
local camel_pattern = [=[\u\|\<\|[-._]\|[[:punct:]]]=]

vim.keymap.set({ 'n', 'v' }, '<S-Right>', function()
  vim.fn.search(camel_pattern, 'W')
end, { desc = 'Jump right (CamelCase)' })

vim.keymap.set({ 'n', 'v' }, '<S-Left>', function()
  vim.fn.search(camel_pattern, 'bW')
end, { desc = 'Jump left (CamelCase)' })

vim.keymap.set('i', '<S-Right>', function()
  vim.cmd('normal! l')
  vim.fn.search(camel_pattern, 'W')
end, { desc = 'Jump right (CamelCase)' })

vim.keymap.set('i', '<S-Left>', function()
  vim.cmd('normal! h')
  vim.fn.search(camel_pattern, 'bW')
end, { desc = 'Jump left (CamelCase)' })
