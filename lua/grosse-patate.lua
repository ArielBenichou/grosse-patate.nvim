local M = {}

M.swap_ternary = function()
  local bufnr = vim.api.nvim_get_current_buf()

  -- Get visual selection marks
  local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(bufnr, "<"))
  local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(bufnr, ">"))

  -- Convert line numbers to 0-indexed.
  local start_row = start_line - 1
  local end_row = end_line - 1

  -- Retrieve the selected lines.
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_row, end_line, false)
  local code = table.concat(lines, "\n")

  -- Call the external Node.js script (adjust the path accordingly)
  local cmd = "node " .. vim.fn.expand("~/personal/grosse-patate.nvim/engine/swap-ternary.js")
  local result = vim.fn.system(cmd, code)

  if vim.v.shell_error ~= 0 then
    vim.notify("Error running refactoring tool", vim.log.levels.ERROR)
    return
  end

  -- Split the result into lines
  local new_lines = {}
  for s in result:gmatch("[^\r\n]+") do
    table.insert(new_lines, s)
  end

  -- Adjust the end column to be exclusive.
  -- Get the last line text from the buffer.
  local end_line_text = vim.api.nvim_buf_get_lines(bufnr, end_row, end_row + 1, false)[1] or ""
  -- Calculate the exclusive end column (end mark is inclusive so add 1, clamped to the length of the line).
  local new_end_col = math.min(end_col + 1, #end_line_text)

  -- Replace the text in the visual selection region.
  vim.api.nvim_buf_set_text(bufnr, start_row, start_col, end_row, new_end_col, new_lines)
end
M.setup = function()
  vim.api.nvim_create_user_command("TsRefactorSwapTernary", M.swap_ternary, { range = true })
end

return M
