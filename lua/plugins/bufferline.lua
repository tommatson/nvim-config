return {
  'akinsho/bufferline.nvim',
  dependencies = { 'moll/vim-bbye' },
  event = 'VeryLazy',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '<leader>x', '<cmd>Bdelete!<cr>', desc = 'Close Buffer' },
    { '<leader>bp', '<cmd>BufferLineTogglePin<cr>', desc = 'Pin Buffer' },
    { '<leader>bo', '<cmd>BufferLineCloseOthers<cr>', desc = 'Close Other Buffers' },
  },
  config = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        themable = true,
        numbers = 'none',
        close_command = 'Bdelete! %d',
        right_mouse_command = 'Bdelete! %d',
        middle_mouse_command = 'Bdelete! %d',
        buffer_close_icon = '✗',
        close_icon = '✗',
        modified_icon = '●',
        left_trunc_marker = '',
        right_trunc_marker = '',
        path_components = 1,
        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count)
          return '(' .. count .. ')'
        end,
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = true,
        show_close_icon = false,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        indicator = { style = 'underline' },
        -- Push bufferline right when neo-tree is open
        offsets = {
          {
            filetype = 'neo-tree',
            text = 'Explorer',
            highlight = 'Directory',
            separator = true,
          },
        },
        sort_by = 'insert_at_end',
      },
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
    }
  end,
}
