return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-tree/nvim-web-devicons", -- Optional: For icons
    { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves the UI of NeoVim's select/input fields
  },
  config = function()
    local env = require('core.env').load()
    local server_url = env.AI_SERVER_URL or 'http://localhost:8080'
    local model_name = env.AI_MODEL_NAME or 'unsloth/Qwen3.6-27B-MTP-GGUF:Q5_K_M'
    local api_key = env.AI_API_KEY or 'EMPTY'

    vim.g.codecompanion_spinner = ""

    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "my_local_openai_thinking",
          tools = {
            opts = {
              default_tools = {
                "ask_questions",
                "create_file",
                "delete_file",
                "file_search",
                "get_changed_files",
                "get_diagnostics",
                "grep_search",
                "insert_edit_into_file",
                "read_file",
                "run_command",
                "web_search",
              },
            },
          },
        },
        inline = {
          adapter = "my_local_openai",
        },
        agent = {
          adapter = "my_local_openai_thinking",
        },
      },
      adapters = {
        http = {
          my_local_openai = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = server_url,
                api_key = api_key,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = model_name,
                  choices = {
                    [model_name] = {
                      meta = {
                        context_window = 32768,
                        max_output_tokens = 4096,
                      },
                    },
                  },
                },
                temperature = {
                  default = 0.7,
                },
                top_p = {
                  default = 0.80,
                },
                presence_penalty = {
                  default = 1.5,
                },
                repetition_penalty = {
                  mapping = "parameters",
                  type = "number",
                  default = 1.0,
                },
                top_k = {
                  mapping = "parameters",
                  type = "number",
                  default = 20,
                },
                chat_template_kwargs = {
                  mapping = "parameters",
                  type = "table",
                  default = {
                    enable_thinking = false,
                  },
                },
              },
            })
          end,
          my_local_openai_thinking = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = server_url,
                api_key = api_key,
                chat_url = "/v1/chat/completions",
              },
              schema = {
                model = {
                  default = model_name,
                  choices = {
                    [model_name] = {
                      meta = {
                        context_window = 32768,
                        max_output_tokens = 4096,
                      },
                    },
                  },
                },
                temperature = {
                  default = 0.6,
                },
                top_p = {
                  default = 0.95,
                },
                presence_penalty = {
                  default = 0.0,
                },
                repetition_penalty = {
                  mapping = "parameters",
                  type = "number",
                  default = 1.0,
                },
                top_k = {
                  mapping = "parameters",
                  type = "number",
                  default = 20,
                },
                chat_template_kwargs = {
                  mapping = "parameters",
                  type = "table",
                  default = {
                    enable_thinking = true,
                    preserve_thinking = true,
                  },
                },
              },
            })
          end,
        },
      },
    })

    -- Spinner / Loading indicator logic
    local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
    local spinner_idx = 1
    local spinner_timer = nil
    local fidget_progress = nil

    local function start_spinner()
      if spinner_timer then return end
      local uv = vim.uv or vim.loop
      spinner_timer = uv.new_timer()
      spinner_timer:start(0, 80, vim.schedule_wrap(function()
        spinner_idx = (spinner_idx % #spinner_frames) + 1
        vim.g.codecompanion_spinner = spinner_frames[spinner_idx]
        pcall(function() require("lualine").refresh() end)
      end))
    end

    local function stop_spinner()
      if spinner_timer then
        spinner_timer:stop()
        spinner_timer:close()
        spinner_timer = nil
      end
      vim.g.codecompanion_spinner = ""
      pcall(function() require("lualine").refresh() end)
    end

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", { clear = true })

    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(request)
        if request.match == "CodeCompanionRequestStarted" then
          start_spinner()
          local ok, fidget = pcall(require, "fidget")
          if ok then
            fidget_progress = fidget.progress.handle.create({
              title = "CodeCompanion",
              message = "Thinking...",
              lsp_client = { name = "CodeCompanion" },
            })
          end
        elseif request.match == "CodeCompanionRequestFinished" then
          stop_spinner()
          if fidget_progress then
            fidget_progress:finish()
            fidget_progress = nil
          end
        end
      end,
    })

    -- Global Keymaps
    vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AI Chat", silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "Inline AI Prompt", silent = true })
    vim.keymap.set({ "v" }, "<leader>ae", ":CodeCompanion<cr>", { desc = "Inline AI Edit / Visual Refactor", silent = true })
    vim.keymap.set({ "n", "v" }, "<leader>ap", "<cmd>CodeCompanionActions<cr>", { desc = "AI Actions Palette", silent = true })
  end,
}
