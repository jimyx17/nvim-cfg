local M = {}

function M.setup()
  --Prepare the system for loading the rest of plugins
  require("base.bootstrap").boot()

  --Obtain the list of pluings and populate them
  local plugins = require("user.plugins")
  require("base.package_manager").setup(plugins)
  vim.notify("Plugins loaded")

  -- Register autocommands
  require("base.autocommands").setup()
  require("base.lsp").setup()
  require("base.dap").setup()
end

return M
