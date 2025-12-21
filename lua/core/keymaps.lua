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

