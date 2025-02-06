local M = {}

local execute_code = require("utils").execute_code
local get_selected_line = require("utils").get_selected_line
local create_null_ls_generator = require("utils").create_null_ls_generator

local function perform_swap_ternary(code)
  return execute_code("swap-ternary.js", code)
end

M.setup_swap_ternary = function()
  local name = "swap-ternary"

  local swapTernaryFn = function(params)
    local lines = get_selected_line(params).lines
    local start_line = get_selected_line(params).start_line
    local end_line = get_selected_line(params).end_line

    local code = table.concat(lines, "\n")

    local new_lines = perform_swap_ternary(code)
    if not new_lines then
      return nil
    end

    return {
      {
        title = name,
        action = function()
          vim.api.nvim_buf_set_lines(params.bufnr, start_line, end_line + 1, false, new_lines)
        end,
      },
    }
  end

  -- Create the swap ternary generator using the factory.
  local swap_ternary_generator = create_null_ls_generator({
    name = name,
    fn = swapTernaryFn,
  })

  return swap_ternary_generator
end

return M
