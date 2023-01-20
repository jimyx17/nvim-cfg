-- Set Default Prefix.
-- Note: You can set a prefix per lsp server in the lv-globals.lua file
local M = {}
local ascii_icons = require("user.ascii_icons")

function M.setup()
  local signs = {
    { name = "DiagnosticSignError", text = ascii_icons.icons.error },
    { name = "DiagnosticSignWarn", text = ascii_icons.icons.warn },
    { name = "DiagnosticSignHint", text = ascii_icons.icons.hint },
    { name = "DiagnosticSignInfo", text = ascii_icons.icons.info },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  local config = { -- your config
    virtual_text = vim.diagnostic.virtual_text,
    signs = signs,
    underline = vim.diagnostic.underline,
    update_in_insert = vim.diagnostic.update_in_insert,
    severity_sort = vim.diagnostic.severity_sort,
    float = vim.diagnostic.float,
  }
  vim.diagnostic.config(config)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, vim.diagnostic.float)
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, vim.diagnostic.float)
end

return M
