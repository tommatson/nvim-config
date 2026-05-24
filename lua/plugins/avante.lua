return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  lazy = false,
  version = false, -- Never set this to "*"
  build = 'make',
  opts = function()
    local env = require('core.env').load()
    local server_url = env.AI_SERVER_URL or 'http://localhost:8080'
    local model_name = env.AI_MODEL_NAME or 'Qwen/Qwen3.6-27B'
    local api_key = env.AI_API_KEY or 'EMPTY'

    -- Set environment variable so avante can pick it up
    vim.env.AVANTE_API_KEY = api_key

    return {
      provider = 'llama_cpp',
      auto_suggestions_provider = 'llama_cpp',
      providers = {
        ['llama_cpp'] = {
          __inherited_from = 'openai',
          endpoint = server_url .. '/v1',
          api_key_name = 'AVANTE_API_KEY',
          model = model_name,
          context_window = 32768, -- Set context window limit so avante knows when to truncate context
          extra_request_body = {
            temperature = 0.7, -- Recommended for non-thinking / instruct mode
            top_p = 0.80,
            max_tokens = 4096,
            chat_template_kwargs = {
              enable_thinking = false, -- Disabling thinking prevents `<think>` tags and duplication during edits
            },
          },
        },
        ['llama_cpp_thinking'] = {
          __inherited_from = 'openai',
          endpoint = server_url .. '/v1',
          api_key_name = 'AVANTE_API_KEY',
          model = model_name,
          context_window = 16384, -- Set context window limit so avante knows when to truncate context
          extra_request_body = {
            temperature = 0.6, -- Recommended for precise coding/thinking tasks
            top_p = 0.95,
            max_tokens = 4096,
            chat_template_kwargs = {
              enable_thinking = true,
              preserve_thinking = true,
            },
          },
        },
      },
      behaviour = {
        auto_suggestions = false, -- Disabled by default for now as requested
        auto_set_keymaps = false, -- Disable automatic keymaps to clean up clutter and prevent crashes!
      },
      mappings = {
        submit = {
          insert = '<C-s>',
          normal = '<CR>',
        },
        suggestion = {
          accept = '<M-l>',
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
        },
      },
    }
  end,
  config = function(_, opts)
    require('avante').setup(opts)

    -- Dynamic provider switching for automatic thinking (chat) / non-thinking (edits)
    local switch_to_thinking = function()
      require("avante.config").override({ provider = "llama_cpp_thinking" })
    end
    local switch_to_edit = function()
      require("avante.config").override({ provider = "llama_cpp" })
    end

    -- Define custom/kept keymaps manually!
    -- This ensures complete control over what is registered and avoids lazy.nvim/avante.nvim conflicts.
    local ask = function()
      switch_to_thinking()
      require('avante.api').ask()
    end
    local quick_chat = function()
      switch_to_thinking()
      require('avante.api').ask({ ask = false })
    end
    local new_ask = function()
      switch_to_thinking()
      require('avante.api').ask({ new_chat = true })
    end
    local edit = function()
      switch_to_edit()
      require('avante.api').edit()
    end

    local zen_mode = function() require('avante.api').zen_mode() end
    local refresh = function() require('avante.api').refresh() end
    local stop = function() require('avante.api').stop() end
    local toggle_debug = function() require('avante').toggle.debug() end
    local toggle_selection = function() require('avante').toggle.selection() end
    local toggle_suggestion = function() require('avante').toggle.suggestion() end
    local repo_map = function() require('avante.repo_map').show() end
    local select_model = function() require('avante.api').select_model() end
    local select_history = function() require('avante.api').select_history() end

    -- Toggle Agent Window (Cursor-like sidebar chat toggle)
    local toggle_agent = function()
      switch_to_thinking()
      vim.cmd('AvanteToggle')
    end
    vim.keymap.set({ 'n', 'v' }, '<leader>ta', toggle_agent, { desc = 'Toggle Agent Window' })
    vim.keymap.set({ 'n', 'v' }, '<leader>tg', toggle_agent, { desc = 'Toggle Agent Window' })
    vim.keymap.set({ 'n', 'v' }, '<leader>tc', toggle_agent, { desc = 'Toggle Agent Window' })

    -- Normal and Visual mappings
    vim.keymap.set({ 'n', 'v' }, '<leader>aa', ask, { desc = 'Ask' })
    vim.keymap.set({ 'n', 'v' }, '<leader>aq', quick_chat, { desc = 'Quick Chat' })
    vim.keymap.set({ 'n', 'v' }, '<leader>an', new_ask, { desc = 'New Ask' })
    vim.keymap.set({ 'n', 'v' }, '<leader>az', zen_mode, { desc = 'Zen Mode' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ae', edit, { desc = 'Edit Code (Visual)' })

    -- Normal mappings
    vim.keymap.set('n', '<leader>ar', refresh, { desc = 'Refresh' })
    vim.keymap.set('n', '<leader>aS', stop, { desc = 'Stop' })
    vim.keymap.set('n', '<leader>ad', toggle_debug, { desc = 'Toggle Debug' })
    vim.keymap.set('n', '<leader>aC', toggle_selection, { desc = 'Toggle Selection' })
    vim.keymap.set('n', '<leader>as', toggle_suggestion, { desc = 'Toggle Suggestion (as)' })
    vim.keymap.set('n', '<leader>ts', toggle_suggestion, { desc = 'Toggle Suggestion (ts)' })
    vim.keymap.set('n', '<leader>aR', repo_map, { desc = 'Display Repo Map' })
    vim.keymap.set('n', '<leader>a?', select_model, { desc = 'Select Model' })
    vim.keymap.set('n', '<leader>ah', select_history, { desc = 'Select History' })
  end,
  dependencies = {
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-tree/nvim-web-devicons',
  },
}
