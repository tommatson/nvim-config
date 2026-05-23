return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  branch = 'master',
  main = 'nvim-treesitter.configs',
  opts = {
    ensure_installed = {
      'lua', 'python', 'javascript', 'typescript', 'tsx',
      'c', 'cpp', 'rust', 'go', 'java',
      'html', 'css', 'json', 'yaml', 'toml',
      'vim', 'vimdoc', 'regex', 'bash', 'make', 'cmake',
      'sql', 'dockerfile', 'gitignore',
      'markdown', 'markdown_inline',
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = { enable = true, disable = { 'ruby' } },
    -- Incremental selection with keybinds
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
  },
}
