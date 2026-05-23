return {
  'karb94/neoscroll.nvim',
  event = 'VeryLazy',
  opts = {
    mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' },
    hide_cursor = false,
    easing = 'quadratic',
    duration_multiplier = 0.6,
  },
}
