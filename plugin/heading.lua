if vim.g.loaded_heading_plugin then
  return
end
vim.g.loaded_heading_plugin = true

-- Create the user command
vim.api.nvim_create_user_command("AddHeading", function()
  require("heading").add_heading()
end, { range = true, desc = "Build a heading comment from selection and paste above" })
