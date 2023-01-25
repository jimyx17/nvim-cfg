local M = {}

-- local Log = require "lvim.core.log"

local ascii_icons = require("user.ascii_icons")
local utils = require("base.utils")

local config = {
  active = true,
  winbar_filetype_exclude = {
    "help",
    "startify",
    "dashboard",
    "lazy",
    "neo-tree",
    "neogitstatus",
    "NvimTree",
    "Trouble",
    "alpha",
    "lir",
    "Outline",
    "spectre_panel",
    "toggleterm",
    "DressingSelect",
    "Jaq",
    "harpoon",
    "dap-repl",
    "dap-terminal",
    "dapui_console",
    "dapui_hover",
    "lab",
    "notify",
    "noice",
    "",
  },
  options = {
    icons = {
      Array = ascii_icons.kind.Array .. " ",
      Boolean = ascii_icons.kind.Boolean,
      Class = ascii_icons.kind.Class .. " ",
      Color = ascii_icons.kind.Color .. " ",
      Constant = ascii_icons.kind.Constant .. " ",
      Constructor = ascii_icons.kind.Constructor .. " ",
      Enum = ascii_icons.kind.Enum .. " ",
      EnumMember = ascii_icons.kind.EnumMember .. " ",
      Event = ascii_icons.kind.Event .. " ",
      Field = ascii_icons.kind.Field .. " ",
      File = ascii_icons.kind.File .. " ",
      Folder = ascii_icons.kind.Folder .. " ",
      Function = ascii_icons.kind.Function .. " ",
      Interface = ascii_icons.kind.Interface .. " ",
      Key = ascii_icons.kind.Key .. " ",
      Keyword = ascii_icons.kind.Keyword .. " ",
      Method = ascii_icons.kind.Method .. " ",
      Module = ascii_icons.kind.Module .. " ",
      Namespace = ascii_icons.kind.Namespace .. " ",
      Null = ascii_icons.kind.Null .. " ",
      Number = ascii_icons.kind.Number .. " ",
      Object = ascii_icons.kind.Object .. " ",
      Operator = ascii_icons.kind.Operator .. " ",
      Package = ascii_icons.kind.Package .. " ",
      Property = ascii_icons.kind.Property .. " ",
      Reference = ascii_icons.kind.Reference .. " ",
      Snippet = ascii_icons.kind.Snippet .. " ",
      String = ascii_icons.kind.String .. " ",
      Struct = ascii_icons.kind.Struct .. " ",
      Text = ascii_icons.kind.Text .. " ",
      TypeParameter = ascii_icons.kind.TypeParameter .. " ",
      Unit = ascii_icons.kind.Unit .. " ",
      Value = ascii_icons.kind.Value .. " ",
      Variable = ascii_icons.kind.Variable .. " ",
    },
    highlight = true,
    separator = " " .. ascii_icons.ui.ChevronRight .. " ",
    depth_limit = 0,
    depth_limit_indicator = "..",
  },
}

function M.setup()
  local status_ok, navic = pcall(require, "nvim-navic")
  if not status_ok then
    return
  end

  M.create_winbar()
  navic.setup(config.options)
end

M.get_filename = function()
  local filename = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"

  if not utils.isempty(filename) then
    local file_icon, hl_group
    local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
    if devicons_ok then
      file_icon, hl_group = devicons.get_icon(filename, extension, { default = true })

      if utils.isempty(file_icon) then
        file_icon = ascii_icons.kind.File
      end
    else
      file_icon = ""
      hl_group = "Normal"
    end

    local buf_ft = vim.bo.filetype

    if buf_ft == "dapui_breakpoints" then
      file_icon = ascii_icons.ui.Bug
    end

    if buf_ft == "dapui_stacks" then
      file_icon = ascii_icons.ui.Stacks
    end

    if buf_ft == "dapui_scopes" then
      file_icon = ascii_icons.ui.Scopes
    end

    if buf_ft == "dapui_watches" then
      file_icon = ascii_icons.ui.Watches
    end

    -- if buf_ft == "dapui_console" then
    --   file_icon = lvim.icons.ui.DebugConsole
    -- end

    local navic_text = vim.api.nvim_get_hl_by_name("Normal", true)
    vim.api.nvim_set_hl(0, "Winbar", { fg = navic_text.foreground })

    return " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. "%#Winbar#" .. filename .. "%*"
  end
end

local get_gps = function()
  local status_gps_ok, gps = pcall(require, "nvim-navic")
  if not status_gps_ok then
    return ""
  end

  local status_ok, gps_location = pcall(gps.get_location, {})
  if not status_ok then
    return ""
  end

  if not gps.is_available() or gps_location == "error" then
    return ""
  end

  if not utils.isempty(gps_location) then
    return "%#NavicSeparator#" .. ascii_icons.ui.ChevronRight .. "%* " .. gps_location
  else
    return ""
  end
end

M.get_winbar = function()
  local value = M.get_filename()

  local gps_added = false
  if not utils.isempty(value) then
    local gps_value = get_gps()
    value = value .. " " .. gps_value
    if not utils.isempty(gps_value) then
      gps_added = true
    end
  end

  if not utils.isempty(value) and utils.get_buf_option "mod" then
    -- TODO: replace with circle
    local mod = "%#LspCodeLens#" .. ascii_icons.ui.Circle .. "%*"
    if gps_added then
      value = value .. " " .. mod
    else
      value = value .. mod
    end
  end

  local num_tabs = #vim.api.nvim_list_tabpages()

  if num_tabs > 1 and not utils.isempty(value) then
    local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
    value = value .. "%=" .. tabpage_number .. "/" .. tostring(num_tabs)
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
  if not status_ok then
    return
  end
end

M.create_winbar = function()
  vim.api.nvim_create_augroup("_winbar", {})
  if vim.fn.has "nvim-0.8" == 1 then
    vim.api.nvim_create_autocmd({
      "CursorHoldI",
      "CursorHold",
      "BufWinEnter",
      "BufFilePost",
      "InsertEnter",
      "BufWritePost",
      "TabClosed",
      "TabEnter",
    }, {
      group = "_winbar",
      callback = function()
        local status_ok, _ = pcall(vim.api.nvim_buf_get_var, 0, "lsp_floating_window")
        if not status_ok then
          -- TODO:
          M.get_winbar()
        end
      end,
    })
  end
end

return M
