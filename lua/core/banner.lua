local M = {}

function M.insert_comment_banner()
  local commentstring = vim.bo.commentstring
  if not commentstring or commentstring == "" then
    commentstring = "// %s"
  end

  local prefix, suffix = commentstring:match("^(.-)%%s(.-)$")
  prefix = prefix or "// "
  suffix = suffix or ""

  prefix = prefix:gsub("%s+$", "") .. " "
  if suffix ~= "" then
    suffix = " " .. suffix:gsub("^%s+", "")
  end

  -- Get active local scope indentation of a newline by temporarily inserting one
  local lnum = vim.fn.line('.')
  vim.api.nvim_buf_set_lines(0, lnum, lnum, false, { "" })
  local new_lnum = lnum + 1
  local indent_val = -1

  if vim.bo.indentexpr ~= "" then
    local save_lnum = vim.v.lnum
    vim.v.lnum = new_lnum
    local ok, val = pcall(vim.api.nvim_eval, vim.bo.indentexpr)
    vim.v.lnum = save_lnum
    if ok and type(val) == "number" and val >= 0 then
      indent_val = val
    end
  end

  if indent_val < 0 and vim.bo.cindent then
    indent_val = vim.fn.cindent(new_lnum)
  end

  if indent_val < 0 then
    indent_val = vim.fn.indent(lnum)
  end

  -- Delete the temporary line
  vim.api.nvim_buf_set_lines(0, lnum, lnum + 1, false, {})

  local indent = ""
  if not vim.bo.expandtab then
    local tabstop = vim.bo.tabstop
    if tabstop <= 0 then tabstop = 8 end
    indent = string.rep("\t", math.floor(indent_val / tabstop)) .. string.rep(" ", indent_val % tabstop)
  else
    indent = string.rep(" ", indent_val)
  end
  local indent_len = string.len(indent)

  vim.ui.input({ prompt = "Banner Title: " }, function(input)
    if not input or input == "" then return end

    local width = 80
    local comment_len = string.len(prefix) + string.len(suffix)
    local dash_len = width - indent_len - comment_len
    if dash_len < 5 then dash_len = 5 end
    local separator_line = string.rep("-", dash_len)

    local lines = {
      indent .. prefix .. separator_line .. suffix,
      indent .. prefix .. input .. suffix,
      indent .. prefix .. separator_line .. suffix,
    }

    vim.api.nvim_put(lines, "l", true, true)
  end)
end

return M
