local M = {}

local Log = require("log")

function M.setup()
  local null_ls = require("null-ls")

  local default_opts = require("user.lsp").get_common_opts()
  null_ls.setup(vim.tbl_deep_extend("force", default_opts, vim.lsp.null_ls.setup))
end

return M
