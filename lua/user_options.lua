local M = {}

function M.setup()
  -- Setup user options to modify basic NVIM behaviour
  require("user.options").setup()

  --First, configure keybindings
  require("user.keymaps").setup()
end

return M
