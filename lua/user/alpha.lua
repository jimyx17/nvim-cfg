local M = {}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    return
  end

  local icons = require "user.ascii_icons"

  local dashboard = require "alpha.themes.dashboard"
  dashboard.section.header.val = require("user.banners").dashboard()
  dashboard.section.buttons.val = {
    dashboard.button("f", icons.dashboard.FindFile .. " Find file", ":Telescope find_files <CR>"),
    dashboard.button("e", icons.dashboard.NewFile .. " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button(
      "p",
      icons.dashboard.FindProject .. " Find project",
      ":lua require('telescope').extensions.projects.projects()<CR>"
    ),
    dashboard.button("r", icons.dashboard.RecentFiles .. " Recent files", ":Telescope oldfiles <CR>"),
    dashboard.button("t", icons.dashboard.FindText .. " Find text", ":Telescope live_grep <CR>"),
    dashboard.button("c", icons.dashboard.Config .. " Config", ":e $MYVIMRC <CR>"),
    dashboard.button("q", icons.dashboard.Quit .. " Quit", ":qa<CR>"),
  }

  dashboard.section.footer.val = require "alpha.fortune"()

  dashboard.section.footer.opts.hl = "Type"
  dashboard.section.header.opts.hl = "Include"
  dashboard.section.buttons.opts.hl = "Keyword"

  dashboard.opts.opts.noautocmd = true
  alpha.setup(dashboard.opts)
end

return M
