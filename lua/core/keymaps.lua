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
local function insert_comment_banner()
  local commentstring = vim.bo.commentstring
  if not commentstring or commentstring == "" then
    commentstring = "// %s"
  end

  local prefix, suffix = commentstring:match("^(.-)%%s(.-)$")
  prefix = prefix or "// "
  suffix = suffix or ""

  prefix = prefix:gsub("%s+$", "") .. " "
  if suffix ~= "" then
    suffix = " " .. suffix:gsub("^%s+", "")
  end

  -- Get active local scope indentation of a newline by temporarily inserting one
  local lnum = vim.fn.line('.')
  vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { "" })
  local new_lnum = lnum + 1
  local indent_val = -1

  if vim.bo.indentexpr ~= "" then
    local save_lnum = vim.v.lnum
    vim.v.lnum = new_lnum
    local ok, val = pcall(vim.api.nvim_eval, vim.bo.indentexpr)
    vim.v.lnum = save_lnum
    if ok and type(val) == "number" and val >= 0 then
      indent_val = val
    end
  end

  if indent_val < 0 and vim.bo.cindent then
    indent_val = vim.fn.cindent(new_lnum)
  end

  if indent_val < 0 then
    indent_val = vim.fn.indent(lnum)
  end

  -- Delete the temporary line
  vim.api.nvim_buf_set_lines(0, lnum, lnum + 1, false, {})

  local indent = ""
  if not vim.bo.expandtab then
    local tabstop = vim.bo.tabstop
    if tabstop <= 0 then tabstop = 8 end
    indent = string.rep("\t", math.floor(indent_val / tabstop)) .. string.rep(" ", indent_val % tabstop)
  else
    indent = string.rep(" ", indent_val)
  end
  local indent_len = string.len(indent)

  vim.ui.input({ prompt = "Banner Title: " }, function(input)
    if not input or input == "" then return end

    local width = 80
    local comment_len = string.len(prefix) + string.len(suffix)
    local dash_len = width - indent_len - comment_len
    if dash_len < 5 then dash_len = 5 end
    local separator_line = string.rep("-", dash_len)

    local lines = {
      indent .. prefix .. separator_line .. suffix,
      indent .. prefix .. input .. suffix,
      indent .. prefix .. separator_line .. suffix,
    }

    vim.api.nvim_put(lines, "l", true, true)
  end)
end

vim.keymap.set("n", "<leader>cb", insert_comment_banner, { desc = "Insert comment banner" })

