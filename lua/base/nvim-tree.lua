local M = {}

local ascii_icons = require("user.ascii_icons")

function M.setup()
  local nvim_tree = require("nvim-tree")
  local nvim_tree_config = require("nvim-tree.config")

  local tree_cb = nvim_tree_config.nvim_tree_callback

  nvim_tree.setup {
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
    renderer = {
      root_folder_modifier = ":t",
      icons = {
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            arrow_open = "",
            arrow_closed = "",
            default = "",
            open = "",
            empty = "",
            empty_open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "",
            staged = "S",
            unmerged = "",
            renamed = "➜",
            untracked = "U",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {
        hint = ascii_icons.icons.hint,
        info = ascii_icons.icons.info,
        warning = ascii_icons.icons.warn,
        error = ascii_icons.icons.error,
      },
    },
    view = {
      width = 30,
      side = "left",
      mappings = {
        list = {
          { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
          { key = "h", cb = tree_cb "close_node" },
          { key = "v", cb = tree_cb "vsplit" },
        },
      },
    },
  }
end

return M
