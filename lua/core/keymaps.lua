-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalheader = ' '

-- Disable default behaviour
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true})

-- Save file, map save to ctrl s, but in terminal settings change cmd s to ctrl s
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save File'})

-- Quit file
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit File'})

-- DO not set into register when we delete
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete Character' })

-- Line replacement when pasting
vim.keymap.set('v', 'p', '"_dP', {noremap = true, silent = true, desc = 'Paste Replacement'})

-- Undo with Ctrl+z in Normal mode
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })

-- Undo with Ctrl+z in Insert mode (Go to Normal, undo, go back to Insert)
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = 'Undo' })

-- Redo in normal mode
vim.keymap.set('n', '<C-g>', '<C-r>', { desc = 'Redo' })

-- Redo in insert mode
vim.keymap.set('i', '<C-g>', '<C-o><C-r>', { desc = 'Redo' })
