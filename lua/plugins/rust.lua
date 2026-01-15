return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', 
    lazy = false, 
    config = function()
      local mason_registry = vim.fn.stdpath('data') .. '/mason/'
      local extension_path = mason_registry .. 'packages/codelldb/extension/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

      local dap = {}
      if vim.fn.filereadable(codelldb_path) == 1 then
        dap = {
          adapter = require('rustaceanvim.config').get_codelldb_adapter(codelldb_path, liblldb_path),
        }
      end

      vim.g.rustaceanvim = {
        dap = dap,
        tools = {
          float_win_config = {
            border = 'rounded',
          },
        },
        server = {
          on_attach = function(client, bufnr)
          end,
          default_settings = {
            ['rust-analyzer'] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
      }
    end
  },
}
