-- Set leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable default behaviour (spacebar shouldn't move cursor)
vim.keymap.set({'n', 'v'}, '<Space>', '<Nop>', { silent = true})

-- Open and close neotree
vim.keymap.set('n', '<leader>c', ':Neotree toggle<CR>', { silent = true, desc = 'Toggle Explorer' })

-- Save file (mapped to Ctrl+S)
vim.keymap.set({'n', 'i'}, '<C-s>', '<cmd> w <CR>', { noremap = true, silent = true, desc = 'Save File'})

-- Quit file (mapped to Ctrl+Q)
vim.keymap.set('n', '<C-q>', '<cmd> q <CR>', { noremap = true, silent = true, desc = 'Quit File'})

-- Do not set into register when we delete (x key)
vim.keymap.set('n', 'x', '"_x', { noremap = true, silent = true, desc = 'Delete Character' })

-- Line replacement when pasting
vim.keymap.set('v', 'p', '"_dP', {noremap = true, silent = true, desc = 'Paste Replacement'})

-- Undo/Redo Mappings (Mirroring terminal Cmd+Z / Cmd+Shift+Z)
-- Undo with Ctrl+z in Normal mode
vim.keymap.set('n', '<C-z>', 'u', { desc = 'Undo' })

-- Undo with Ctrl+z in Insert mode (Go to Normal, undo, go back to Insert)
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = 'Undo' })

-- Redo in normal mode
vim.keymap.set('n', '<C-g>', '<C-r>', { desc = 'Redo' })

-- Redo in insert mode
vim.keymap.set('i', '<C-g>', '<C-o><C-r>', { desc = 'Redo' })

-- Map paste to Cmd V (using <C-]> as bridge)
vim.keymap.set('i', '<C-]>', '<C-r><C-p>+', { desc= "Paste from system clipboard"})
vim.keymap.set('n', '<C-]>', '"+p', { desc = 'Paste from system clipboard'})


vim.keymap.set({ 'n', 'v' }, 'gl', '$', { desc = 'Go to end of line' })

vim.keymap.set({ 'n', 'v' }, 'gh', '^', { desc = 'Go to start of line' })


local camel_pattern = [=[\u\|\<\|[-._]\|[[:punct:]]]=]

vim.keymap.set({ 'n', 'v' }, '<S-Right>', function()
  vim.fn.search(camel_pattern, 'W') 
end, { desc = 'Jump right (CamelCase/Symbols)' })

vim.keymap.set({ 'n', 'v' }, '<S-Left>', function()
  vim.fn.search(camel_pattern, 'bW')
end, { desc = 'Jump left (CamelCase/Symbols)' })

-- Insert Mode support for Shift+Arrows
vim.keymap.set('i', '<S-Right>', function()
  vim.cmd("normal! l") -- Move right once to avoid getting stuck on the current char
  vim.fn.search(camel_pattern, 'W') 
end, { desc = 'Jump right (CamelCase/Symbols)' })

vim.keymap.set('i', '<S-Left>', function()
  vim.cmd("normal! h") -- Move left once to avoid getting stuck
  vim.fn.search(camel_pattern, 'bW')
end, { desc = 'Jump left (CamelCase/Symbols)' })
