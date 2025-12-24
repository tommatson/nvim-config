-- Options

-- Show line numbers
vim.opt.number = true

-- Relative line numbers
vim.opt.relativenumber = false

-- Line we're on looks different for the line number
vim.opt.cursorline = true

-- Allow copy
vim.opt.clipboard = 'unnamedplus'

-- No wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Auto indent on new line
vim.opt.autoindent = true

-- Search case insensitive
vim.ignorecase= true
vim.opt.smartcase = true

-- Save undo history
vim.o.undofile = true

-- Indentation settings
-- Convert tabs to spaces
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Smart backspace
vim.opt.softtabstop = 2 
-- Never add real tab character
vim.opt.expandtab = true
-- If wrapped, keep indent
vim.opt.breakindent = true

-- Error hover time (ms)
vim.opt.updatetime = 250

-- Persistent highlighting after search
vim.opt.hlsearch = false

-- Make gutter always open for line numbers
vim.opt.signcolumn = 'yes'

-- Enable more colours
vim.opt.termguicolors = true

-- Show actual markdown
vim.opt.conceallevel = 0

-- Limit autocomplete list
vim.opt.pumheight = 10

vim.opt.cmdheight = 1 

-- Where new tabs appear 
vim.opt.splitbelow = true
vim.opt.splitright = true

-- No crash file save
vim.opt.swapfile = false

vim.opt.fileencoding = 'utf-8'

vim.opt.backup = false

vim.opt.writebackup = false

-- Option completion
vim.opt.completeopt = 'menuone,noselect'

-- Backspace logic
vim.o.backspace = 'indent,eol,start'
vim.o.whichwrap = 'bs<>[]hl'

-- Stop autocomplete spam
vim.opt.shortmess:append 'c'

-- Disable continuing comments
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Do not load old pulgins
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'

-- Scrolling
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8

-- Chooses what characters w and arrows skip over
vim.opt.iskeyword:append("-")
vim.opt.iskeyword:append(".")



