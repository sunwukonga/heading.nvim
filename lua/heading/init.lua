local M = {}

function M.add_heading()
  local comment_styles = require('heading.comment-styles')
  local FiletypeStyles = comment_styles.FiletypeStyles
  local buildComment = comment_styles.buildComment
  local ft = vim.bo.filetype

  local s = vim.fn.getpos("'<")
  local e = vim.fn.getpos("'>")
  local bufnr = vim.api.nvim_get_current_buf()
  local l1, c1 = s[2], s[3]
  local l2, c2 = e[2], e[3]

  if l1 ~= l2 then
    vim.notify('Selection can only be a single line!')
    return
  end

  -- Get the selected lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, l1 - 1, l2, false)
  local line = lines[1]
  local selection = line:sub(c1, c2)
  -- capture the inner run of characters after stripping spaces at both ends
  local trimmed = selection:match("^%s*(.-)%s*$")
  if (string.len(trimmed) > 64) then
    vim.notify('Selection is too big!')
    return
  end
  if (string.len(trimmed) < 1) then
    vim.notify('Selection contains nothing!')
    return
  end

  -- Insert the result immediately before the selection
  vim.api.nvim_buf_set_lines(
    0, l1 - 1, l1 - 1, false, buildComment(FiletypeStyles[ft], trimmed))

end

return M
