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

---Checks whether input string is nil or empty
---@param s string to be checked
---@return true|false
function M.isempty(s)
  return s == nil or s == ""
end

---Get buffer options
---@param opt string option to to be obtained
---@return any
function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

---Join path segments passed as input
---@return string
function M.join_paths(...)
  local result = table.concat({ ... }, path_sep)
  return result
end

---Split path in dir + basefile/basedir
---@return string
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

---Returns whether the path is a directory and is empty
---@return true|false
function M.is_directory_empty(path)

  if not M.is_directory(path) then
    return false
  end

  local d = vim.fn.readdir(path)

  return vim.fn.empty(d) == 1 or false
end

---Returns whether str starts with subpattern "start"
---@return true|false
function M.string_starts_with(str, start)
  return str:sub(1, #start) == start
end

---Returns whether str ends with subpattern "start"
---@return true|false
function M.string_ends_with(str, ending)
  return ending == "" or str:sub(- #ending) == ending
end

---Removes files pointed by path
--@return nil
function M.remove_path(path)
  assert(M.string_starts_with(path, M.get_cache_dir()) or M.string_starts_with(path, M.get_runtime_dir()))
  assert(not path:find("..", 0, true), path)
  assert(not path:find("//", 0, true), path)
  vim.fn.delete(path, "rf")
end

---Write data to a file
---@param path string can be full or relative to `cwd`
---@param txt string|table text to be written, uses `vim.inspect` internally for tables
---@param flag string used to determine access mode, common flags: "w" for `overwrite` or "a" for `append`
function M.write_file(path, txt, flag)
  local data = type(txt) == "string" and txt or vim.inspect(txt)
  uv.fs_open(path, flag, 438, function(open_err, fd)
    assert(not open_err, open_err)
    uv.fs_write(fd, data, -1, function(write_err)
      assert(not write_err, write_err)
      uv.fs_close(fd, function(close_err)
        assert(not close_err, close_err)
      end)
    end)
  end)
end

---Return whether the server defined by name is active
---@return true|false
function M.is_client_active(name)
  local clients = vim.lsp.get_active_clients()
  return find_first(clients, function(client)
    return client.name == name
  end)
end

--HACK: Setup nvim cache path
vim.fn.stdpath = function(obj)
  if obj == "cache" then
    return M.get_cache_dir()
  end
  return vim.call("stdpath", obj)
end

--- Find the first entry for which the predicate returns true.
-- @param t The table
-- @param predicate The function called for each entry of t
-- @return The entry for which the predicate returned True or nil
function M.find_first(t, predicate)
  for _, entry in pairs(t) do
    if predicate(entry) then
      return entry
    end
  end
  return nil
end

--- Check if the predicate returns True for at least one entry of the table.
-- @param t The table
-- @param predicate The function called for each entry of t
-- @return True if predicate returned True at least once, false otherwise
function M.contains(t, predicate)
  return M.find_first(t, predicate) ~= nil
end

return M
