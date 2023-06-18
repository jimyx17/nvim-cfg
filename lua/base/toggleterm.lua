local M = {}

function M.setup()
  local toggleterm = require "toggleterm"

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

  function M.start_lazygit()
    lazygit:toggle()
  end
end

function M.exec_toggle(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(opts.size, opts.direction)
end

return M
