local M = {}

local fn = vim.fn
local utils = require "utils"

function M.boot()
  -- Automatically install lazy
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
end


return M
