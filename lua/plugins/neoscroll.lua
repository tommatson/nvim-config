return {
  'karb94/neoscroll.nvim',
  event = 'VeryLazy',
  config = function()
    local neoscroll = require('neoscroll')
    neoscroll.setup({
      mappings = {}, -- Disable all default keyboard mappings
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing = 'quadratic',
    })

  end,
}
