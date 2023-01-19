local M = {}

local uv = vim.loop
local path_sep = uv.os_uname().version:match "Windows" and "\\" or "/"

local function find_first(t, predicate)
  for _, entry in pairs(t) do
    if predicate(entry) then
      return entry
    end
  end
end

---Join path segments passed as input
---@return string
function M.join_paths(...)
  local result = table.concat({...}, path_sep)
  return result
end

---Split path in dir + basefile/basedir
---#return string
function M.split_path(fp)
  return fp:match("(.*)[/\\](.*)$")
end

---Returns nvim runtime directory
---@return string|nil
function M.get_runtime_dir()
  local result = os.getenv("NVIM_RUNTIME_DIR")
  if not result then
    return vim.call("stdpath", "data")
  end
  return result
end

---Returns nvim configuration directory
---@return string|nil
function M.get_config_dir()
  local result = os.getenv("NVIM_CONFIG_DIR")
  if not result then
    return vim.call("stdpath", "config")
  end
  return result
end

---Returns nvim plugin image directory
---@return string|nil
function M.get_plugin_image_dir()
  local config_dir = M.get_runtime_dir()
  return M.join_paths(config_dir, "data", "lazy", "plugins")
end

---Returns nvim cache directory
---@return string|nil
function M.get_cache_dir()
  local result = os.getenv("NVIM_CACHE_DIR")
  if not result then
    return vim.call("stdpath", "cache")
  end
  return result
end

---Returns whether the path is a directory
---@return true|false
function M.is_directory(path)
  local stat = uv.fs_stat(path)
  return stat and stat.type == "directory" or false
end

---Return whether the server defined by name is active
---@return true|false
function M.is_client_active(name)
  local clients = vim.lsp.get_active_clients()
  return find_first(clients, function (client)
    return client.name == name
  end)
end

--HACK: Setup nvim cache path
vim.fn.stdpath = function (obj)
  if obj == "cache" then
    return M.get_cache_dir()
  end
  return vim.call("stdpath", obj)
end

return M
