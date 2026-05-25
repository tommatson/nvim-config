vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'core.options'
require 'core.keymaps'

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  require 'plugins.colourtheme',
  require 'plugins.neotree',
  require 'plugins.bufferline',
  require 'plugins.lualine',
  require 'plugins.treesitter',
  require 'plugins.telescope',
  require 'plugins.lsp',
  require 'plugins.autocompletion',
  require 'plugins.gitsigns',
  require 'plugins.alpha',
  require 'plugins.markdown',
  require 'plugins.rust',
  require 'plugins.autopairs',
  require 'plugins.colourhighlight',
  require 'plugins.whichkey',
  require 'plugins.indent',
  require 'plugins.noice',
  require 'plugins.todo',
  require 'plugins.surround',
  require 'plugins.codecompanion',
})

-- Disable auto-commenting on new lines for all filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove({ 'r', 'o' })
  end,
})
