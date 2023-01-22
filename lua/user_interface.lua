local M = {}

function M.setup()
  -- Define the new colorscheme
  require("base.colorscheme").setup(vim.g.theme)

  -- Create the dashboard menu
  require("base.alpha").setup()

  -- Create "tab" like buffers
  require("base.bufferline").setup()

  -- Setup status bar
  require("base.lualine").setup()

  -- Pop windows. ie Telescope
  require("base.telescope").setup()

  -- Setup file browser
  require("base.nvim-tree").setup()

  --Highlight other uses of the word under score
  require("base.illuminate").setup()
end

return M
