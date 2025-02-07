local M = {}
local generator_factory = require("generator_factory")

M.setup = function()
  return generator_factory.create_generator("swap-ternary", "swap-ternary.js")
end

return M
