-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable spacebar default
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Delete character without copying (black hole register)
vim.keymap.set({ 'n', 'v' }, 'x', '"_x', { desc = 'Delete character without copying' })


-- Disable suspension (Ctrl-Z)
vim.keymap.set({ 'n', 'v', 'i', 'c' }, '<C-z>', '<Nop>', { silent = true })


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
local alphanumeric_end_pattern = [=[\v[a-zA-Z0-9]\ze([^a-zA-Z0-9]|$)]=]

vim.keymap.set('n', '<S-Right>', function()
  if vim.fn.search(alphanumeric_end_pattern, 'W') > 0 then
    local col = vim.fn.col('.')
    local line_len = string.len(vim.fn.getline('.'))
    if col < line_len then
      vim.cmd('normal! l')
    end
  end
end, { desc = 'Jump right (Alphanumeric End)' })

vim.keymap.set('v', '<S-Right>', function()
  vim.fn.search(alphanumeric_end_pattern, 'W')
end, { desc = 'Jump right (Alphanumeric End)' })

vim.keymap.set({ 'n', 'v' }, '<S-Left>', function()
  vim.fn.search(alphanumeric_pattern, 'bW')
end, { desc = 'Jump left (Alphanumeric)' })

vim.keymap.set('i', '<S-Right>', function()
  if vim.fn.search(alphanumeric_end_pattern, 'W') > 0 then
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] + 1 })
  end
end, { desc = 'Jump right (Alphanumeric End)' })

vim.keymap.set('i', '<S-Left>', function()
  vim.cmd('normal! h')
  vim.fn.search(alphanumeric_pattern, 'bW')
end, { desc = 'Jump left (Alphanumeric)' })

-- Inverse trackpad/mouse scroll wheel directions
vim.keymap.set({ 'n', 'v', 'i' }, '<ScrollWheelLeft>', '<ScrollWheelRight>')
vim.keymap.set({ 'n', 'v', 'i' }, '<ScrollWheelRight>', '<ScrollWheelLeft>')

-- Insert styled comment banner (e.g., // ----------- )
vim.keymap.set("n", "<leader>cb", function()
  require("core.banner").insert_comment_banner()
end, { desc = "Insert comment banner" })

