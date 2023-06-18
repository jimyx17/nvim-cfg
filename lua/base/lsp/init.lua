local M = {}
local u = require "base.utils"
local Log = require "base.log"
local autocmds = require "base.autocommands"

local function add_lsp_buffer_options(bufnr)
  for k, v in pairs(vim.lsp.buffer_options) do
    vim.api.nvim_buf_set_option(bufnr, k, v)
  end
end

local function add_lsp_buffer_keybindings(bufnr)
  local mappings = {
    normal_mode = "n",
    insert_mode = "i",
    visual_mode = "v",
  }

  for mode_name, mode_char in pairs(mappings) do
    for key, remap in pairs(vim.lsp.buffer_mappings[mode_name]) do
      local opts = { buffer = bufnr, desc = remap[2], noremap = true, silent = true }
      vim.keymap.set(mode_char, key, remap[1], opts)
    end
  end
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.common_on_exit(_, _)
  if vim.lsp.document_highlight then
    autocmds.clear_augroup "lsp_document_highlight"
  end
  if vim.lsp.code_lens_refresh then
    autocmds.clear_augroup "lsp_code_lens_refresh"
  end
end

function M.common_on_init(client, bufnr)
  client.offset_encoding = "utf-8"
  if vim.lsp.on_init_callback then
    vim.lsp.on_init_callback(client, bufnr)
    Log:debug "Called lsp.on_init_callback"
    return
  end
end

function M.common_on_attach(client, bufnr)
  if vim.lsp.on_attach_callback then
    vim.lsp.on_attach_callback(client, bufnr)
    Log:debug "Called lsp.on_attach_callback"
  end
  local lu = require "base.lsp.utils"
  -- if vim.lsp.document_highlight then
  lu.setup_document_highlight(client, bufnr)
  -- end
  -- if vim.lsp.code_lens_refresh then
  lu.setup_codelens_refresh(client, bufnr)
  -- end
  add_lsp_buffer_keybindings(bufnr)
  add_lsp_buffer_options(bufnr)
  lu.setup_document_symbols(client, bufnr)

  require("illuminate").on_attach(client, bufnr)
end

function M.get_common_opts()
  return {
    on_attach = M.common_on_attach,
    on_init = M.common_on_init,
    on_exit = M.common_on_exit,
    capabilities = M.common_capabilities(),
  }
end

function M.setup()
  Log:debug "Setting up LSP support"

  local lsp_status_ok, _ = pcall(require, "lspconfig")
  if not lsp_status_ok then
    return
  end

  require("nlspsettings").setup(vim.lsp.nlsp_settings.setup)

  -- Setting up the LSP installer
  require("base.lsp.mason").setup()

  local util = require "lspconfig.util"
  -- automatic_installation is handled by lsp-manager
  util.on_setup = nil

  require("base.lsp.null-ls").config()
  require("base.lsp.null-ls").setup()

  autocmds.configure_format_on_save()
end

return M
