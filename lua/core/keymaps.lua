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



-- For the following keybinds, we map them, then change the iterm mappings
-- E.g In terminal settings we map Cmd Shift Z to Ctrl G 

-- Undo with Ctrl+z in Normal mode
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })

-- Undo with Ctrl+z in Insert mode (Go to Normal, undo, go back to Insert)
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = 'Undo' })

-- Redo in normal mode
vim.keymap.set('n', '<C-g>', '<C-r>', { desc = 'Redo' })

-- Redo in insert mode
vim.keymap.set('i', '<C-g>', '<C-o><C-r>', { desc = 'Redo' })

-- Map paste to Cmd P
vim.keymap.set('i', '<C-]>', '<C-r>+', { desc= "Paste from system clipboard"})
vim.keymap.set('n', '<C-]>', '"+p', { desc = 'Paste from system clipboard'})

-- Save all keymap
vim.keymap.set({'n', 'i'}, '<C-^>', '<cmd>wa<CR>', { desc = 'Save all files' })
