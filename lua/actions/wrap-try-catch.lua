local M = {}
local generator_factory = require("generator_factory")

M.setup = function()
  return generator_factory.create_generator("wrap-try-catch", "wrap-try-catch.js")
end

return M
