return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      transparent_background = false,
      term_colors = true,
      styles = {
        comments = { 'italic' },
        conditionals = { 'italic' },
        functions = {},
        keywords = { 'bold' },
        strings = {},
        variables = {},
        types = { 'bold' },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        neotree = true,
        telescope = { enabled = true },
        treesitter = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { 'undercurl' },
            hints = { 'undercurl' },
            warnings = { 'undercurl' },
            information = { 'undercurl' },
          },
        },
        indent_blankline = { enabled = true },
        noice = true,
        which_key = true,
        fidget = true,
        markdown = true,
        notify = true,
      },
    })
    vim.cmd.colorscheme 'catppuccin'
  end,
}
