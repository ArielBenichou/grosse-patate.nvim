local execute_code = require("utils").execute_code
local get_selected_line = require("utils").get_selected_line
local create_null_ls_generator = require("utils").create_null_ls_generator

local M = {}

-- Factory function that creates a generator based on the provided name and JS file.
function M.create_generator(name, js_file)
  local action_fn = function(params)
    local selection = get_selected_line(params)
    local code = table.concat(selection.lines, "\n")
    local new_lines = execute_code(js_file, code)
    if not new_lines then
      return nil
    end
    vim.api.nvim_buf_set_lines(params.bufnr, selection.start_line, selection.end_line + 1, false, new_lines)
  end

  local generator_fn = function(params)
    return {
      {
        title = name,
        action = function()
          action_fn(params)
        end,
      },
    }
  end

  return create_null_ls_generator({
    name = name,
    fn = generator_fn,
  })
end

return M
