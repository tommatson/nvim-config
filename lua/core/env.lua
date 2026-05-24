local M = {}
local cached_env = nil

function M.load()
  if cached_env then
    return cached_env
  end

  local env = {}
  local config_path = vim.fn.stdpath('config')
  local env_file = config_path .. '/.env'

  local f = io.open(env_file, 'r')
  if f then
    for line in f:lines() do
      -- Parse KEY=VALUE lines, ignoring comments and empty lines
      if not line:match('^%s*#') and not line:match('^%s*$') then
        local key, val = line:match('^%s*([^=]+)%s*=%s*(.-)%s*$')
        if key and val then
          -- Strip wrapping quotes if any
          val = val:gsub('^["\']', ''):gsub('["\']$', '')
          env[key] = val
        end
      end
    end
    f:close()
  end

  cached_env = env
  return env
end

return M
