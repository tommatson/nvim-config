return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    signs_staged = {
      add = { text = '│' },
      change = { text = '│' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
    -- Keymaps for navigating and managing hunks
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end
      map('n', ']h', gs.next_hunk, 'Next Hunk')
      map('n', '[h', gs.prev_hunk, 'Prev Hunk')
      map('n', '<leader>gp', gs.preview_hunk, 'Preview Hunk')
      map('n', '<leader>gs', gs.stage_hunk, 'Stage Hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Reset Hunk')
      map('n', '<leader>gb', gs.blame_line, 'Blame Line')
    end,
  },
}
