return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'

    dashboard.section.header.val = {
      [[                                          ]],
      [[   ███╗   ██╗██╗   ██╗██╗███╗   ███╗  ]],
      [[   ████╗  ██║██║   ██║██║████╗ ████║  ]],
      [[   ██╔██╗ ██║██║   ██║██║██╔████╔██║  ]],
      [[   ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║  ]],
      [[   ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║  ]],
      [[   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝  ]],
      [[                                          ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', '  Find File', ':Telescope find_files<CR>'),
      dashboard.button('r', '  Recent Files', ':Telescope oldfiles<CR>'),
      dashboard.button('g', '  Grep Text', ':Telescope live_grep<CR>'),
      dashboard.button('e', '  New File', ':ene <BAR> startinsert<CR>'),
      dashboard.button('c', '  Config', ':e $MYVIMRC<CR>'),
      dashboard.button('q', '  Quit', ':qa<CR>'),
    }

    dashboard.section.footer.val = ''

    dashboard.section.header.opts.hl = 'AlphaHeader'
    dashboard.section.buttons.opts.hl = 'AlphaButtons'
    dashboard.section.footer.opts.hl = 'AlphaFooter'

    dashboard.opts.opts.noautocmd = true

    alpha.setup(dashboard.opts)

    -- Show lazy stats after loading
    vim.api.nvim_create_autocmd('User', {
      pattern = 'LazyVimStarted',
      callback = function()
        local stats = require('lazy').stats()
        dashboard.section.footer.val = '⚡ ' .. stats.count .. ' plugins loaded in ' .. string.format('%.1f', stats.startuptime) .. 'ms'
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
