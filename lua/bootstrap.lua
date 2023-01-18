local fn = vim.fn
local utils = require("utils")

-- Automatically install packer
local plugin_path = utils.get_plugin_image_dir()
local lazy_install_path = utils.join_paths(plugin_path, "lazy.nvim")

if not utils.is_directory(lazy_install_path) then
  print "First boot with Lazy package manager"
  if not utils.is_directory(plugin_path) then
    vim.fn.mkdir(plugin_path, "p")
  end
  fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazy_install_path,
  }
end

--Setup paths
vim.opt.runtimepath:append(lazy_install_path)
vim.opt.runtimepath:append(utils.join_paths(plugin_path, "*"))

local lazy_cache = require "lazy.core.cache"
lazy_cache.setup {
  performance = {
    enabled = true,
    cache = {
      path = utils.join_paths(utils.get_cache_dir(), "lazy"),
    },
  },
}
--HACK: prevent lazy to call setup again
lazy_cache.setup = function() end

---Setup main plugin object
local plugin_manager = {}
local Log = require("log")

function plugin_manager.reset_cache()
  os.remove(require("lazy.core.cache").config.path)
end

function plugin_manager.update_configuration(configuration)
  local current_config = require("lazy.core.config")
  local lazy = require("lazy")
  current_config.spec = configuration

  require("lazy.core.plugin").load(true)
  require("lazy.core.plugin").update_state()

  local plugins_not_installed = vim.tbl_filter(function(plugin)
    return not plugin._installed
  end, current_config.plugins)

  if #plugins_not_installed > 0 then
    lazy.install = { wait = true }
  end

  if #current_config.to_clean > 0 then
    lazy.clean {wait = true, show = false}
  end
end

function plugin_manager.update_plugin_list(configuration)
  local ok, lazy = pcall(require, "lazy")
  if not ok then
    print "Lazy has not been loaded. Wait longer or check why it's not loading"
    return
  end

  -- Delete all plugins downloaded. This will remove lazy itself?
  vim.opt.runtimepath:remove(utils.join_paths(plugin_path, "*"))

  local ok = xpcall(function ()
    local opts = {
      install = {
        missing = true
      },
      ui = {
        border = "rounded",
      },
      root = plugin_path,
      git = {
        timeout = 120
      },
      lockfile = utils.join_paths(utils.get_config_dir(), "pkg_mgr_lock.json"),
      performance = {
        rtp = {
          reset = false,
          disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
          },
        },
      },
      readme = {
        root = utils.join_paths(utils.get_runtime_dir(), "lazy", "readme")
      },
    }
    lazy.setup(configuration, opts)
  end, debug.traceback)

  if not ok then
    Log:warn "Errors found while loading plugins list"
    Log:trace(debug.traceback())
  end
end



vim.g.pkg_mgr = plugin_manager

