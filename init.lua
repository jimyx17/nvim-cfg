---Main configuration init flow

---STAGE 1: boot and initialize lower layer bindings and behaviour
--
-- Setup user options to modify basic NVIM behaviour
require("user.options").setup()

--First, configure keybindings
require("user.keymaps").setup()

--Prepare the system for loading the rest of plugins
require("bootstrap").boot()
require("package_manager").setup()

--Obtain the list of pluings and populate them
local plugins = require("user.plugins")
vim.g.pkg_mgr.update_plugin_list(plugins)
vim.notify_once("Plugin load finished")

-- Register autocommands
require("user.autocommands").setup()


--- STAGE 2: configure first UI interface

-- Define the new colorscheme
require("user.colorscheme").setup()

-- Create the dashboard menu
require("user.alpha").setup()

-- Create "tab" like buffers
require("user.bufferline").setup()

-- Setup status bar
require("user.lualine").setup()

---STAGE 3: configure the rest of plugins
--At this point we can add the rest of configuration 
--of this nvim config. 

-- Autocomplete.
require("user.cmp").setup()

-- Pop windows. ie Telescope
require("user.telescope").setup()

-- Setup file browser
require("user.nvim-tree").setup()

require("user.treesitter").setup()
require("user.autopairs").setup()
require("user.comment").setup()
require("user.toggleterm").setup()
require("user.project").setup()
require("user.illuminate").setup()
require("user.indentline").setup()
require("user.lsp").setup()
require("user.dap").setup()
