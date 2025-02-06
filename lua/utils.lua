local M = {}

local null_ls = require("null-ls")

M.get_engine_path = function(file)
  local source = debug.getinfo(1, "S").source
  local dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
  return dir .. "/../engine/dist/actions/" .. file
end

M.execute_code = function(file, code)
  local cmd = "node " .. M.get_engine_path(file)
  local result = vim.fn.system(cmd, code)

  if vim.v.shell_error ~= 0 then
    vim.notify("Error running refactoring tool", vim.log.levels.ERROR)
    return nil
  end

  return vim.split(result, "\n")
end

M.get_selected_line = function(params)
  local start_line = params.range.row - 1
  local end_line = params.range.end_row - 1

  local lines = vim.api.nvim_buf_get_lines(params.bufnr, start_line, end_line + 1, false)
  return {
    start_line = start_line,
    end_line = end_line,
    lines = lines,
  }
end

M.create_null_ls_generator = function(opts)
  return {
    name = opts.name,
    method = opts.method or null_ls.methods.CODE_ACTION,
    filetypes = opts.filetypes or { "typescript", "javascript" },
    generator = {
      fn = opts.fn,
      to_stdin = opts.to_stdin or false,
      format = opts.format or "raw",
    },
  }
end

return M
