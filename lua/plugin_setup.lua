local M = {}

function M.setup()
  -- Autocomplete.
  require("base.cmp_config").setup()

  -- Language parser/interpreter/highliting
  require("base.treesitter").setup()

  -- Close open symbols
  require("base.autopairs").setup()

  -- Comment out different languages
  require("base.comment").setup()

  -- Create terminal inside NVIM
  require("base.toggleterm").setup()

  -- Read/Open projects
  require("base.project").setup()

  -- Show lines with the same level of indentation
  require("base.indentline").setup()
end

return M
