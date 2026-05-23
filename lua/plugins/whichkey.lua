return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    delay = 300,
    icons = {
      separator = '→',
    },
    spec = {
      { '<leader>s', group = 'Search' },
      { '<leader>c', group = 'Code / Explorer' },
      { '<leader>d', group = 'Document' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>n', group = 'Neo-tree' },
      { '<leader>r', group = 'Rename' },
    },
  },
}
