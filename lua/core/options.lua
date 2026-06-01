-- Options

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true

-- System clipboard
vim.opt.clipboard = 'unnamedplus'

-- Mouse support (click, drag-select, scroll, resize splits)
vim.opt.mouse = 'a'
vim.opt.mousemodel = 'extend'
vim.opt.mousescroll = 'ver:1,hor:1'

-- No wrapping
vim.opt.wrap = false
vim.opt.linebreak = true

-- Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.breakindent = true

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Undo
vim.opt.undofile = true

-- Timing
vim.opt.updatetime = 200
vim.opt.timeoutlen = 400

-- UI
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.conceallevel = 0
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.showmode = false
vim.opt.laststatus = 3

-- Smooth scrolling (neovim 0.10+)
vim.opt.smoothscroll = true

-- Splits open in sensible directoins
vim.opt.splitbelow = true
vim.opt.splitright = true

-- No swap or backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.fileencoding = 'utf-8'

-- Completion
vim.opt.completeopt = 'menuone,noselect'

-- Backspace
vim.opt.backspace = 'indent,eol,start'
vim.opt.whichwrap = 'bs<>[]hl'

-- Scrolling context
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Word boundaries
vim.opt.iskeyword:append('-')
vim.opt.iskeyword:append('.')

-- Suppress completion messages
vim.opt.shortmess:append 'c'

-- Disable auto-commenting on new lines
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

-- Skip old vim runtime
vim.opt.runtimepath:remove '/usr/share/vim/vimfiles'

-- Filetype associations
vim.filetype.add({
  extension = {
    tpp = 'cpp',
  },
})

