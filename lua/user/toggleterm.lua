local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
  },
}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new { cmd = "lazygit", hidden = true, direction = "tab" }

local M = {}

function M.start_lazygit()
  lazygit:toggle()
end

return M
