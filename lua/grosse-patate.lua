local M = {}

local swap_ternary = require("actions.swap_ternary").setup
local wrap_try_catch = require("actions.wrap-try-catch").setup

local null_ls = require("null-ls")
function M.setup()
  null_ls.register(swap_ternary)
  null_ls.register(wrap_try_catch)
end

return M
