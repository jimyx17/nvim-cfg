local M = {}

local fn = vim.fn
local utils = require("utils")

function download_plugin(url)
  -- Automatically install lazy
  local plugin_path = utils.get_plugin_image_dir()
  local _, plugin_name = utils.split_path(url)
  local plugin_install_path = utils.join_paths(plugin_path, plugin_name)

  if not utils.is_directory(plugin_install_path) then
    print(string.format("no %s plugin found. need to boot it up", plugin_name))
    if not utils.is_directory(plugin_path) then
      vim.fn.mkdir(plugin_path, "p")
    end
    fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      url,
      plugin_install_path,
    }
  end

  return plugin_install_path
end

function install_lazy()
  local lazy_install_path = download_plugin("https://github.com/folke/lazy.nvim")
--Setup Lazy path
  vim.opt.runtimepath:append(lazy_install_path)
end

function install_logger()
  local logger_install_path = download_plugin("https://github.com/Tastyep/structlog.nvim")
--Setup logger path
  vim.opt.runtimepath:append(logger_install_path)
end

function init_lazy_cache()
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

function M.boot()
  install_lazy()
  install_logger()
  vim.opt.runtimepath:append(utils.join_paths(utils.get_plugin_image_dir(), "*"))
  init_lazy_cache()
  require("log"):set_level(vim.log.level)
end


return M
