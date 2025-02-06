local M = {}

local swap_ternary_generator = require("actions.swap_ternary").setup_swap_ternary

local null_ls = require("null-ls")
function M.setup()
  null_ls.register(swap_ternary_generator)
end

return M
