local M = {}

function M.setup()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    return
  end

  local actions = require("telescope.actions")

  telescope.setup {
    defaults = {

      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = {
        { "vendor/*", "%.lock", "__pycache__/*", "%.sqlite3" },
        { "%.ipynb", "node_modules/*", "%.jpg", "%.jpeg", "%.png" },
        { "%.svg", "%.otf", "%.ttf", ".git/", "%.webp", ".dart_tool/" },
        { ".github/", ".gradle/", ".idea/", ".settings/", ".vscode/" },
        { "__pycache__/", "build/", "env/", "gradle/" },
        { "node_modules/", "target/", "%.pdb", "%.dll", "%.class" },
        { "%.exe", "%.cache", "%.ico", "%.pdf", "%.dylib", "%.jar" },
        { "%.docx", "%.met", "smalljre_*/*", ".vale/", "%.burp" },
        { "%.mp4", "%.mkv", "%.rar", "%.zip", "%.7z", "%.tar" },
        { "%.bz2", "%.epub", "%.flac", "%.tar.gz" },
      },

      mappings = {
        i = {
          ["<Down>"] = actions.cycle_history_next,
          ["<Up>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
  }
end

return M
