local M = {}

function M.setup()
  local configs = require("nvim-treesitter.configs")

  configs.setup {
    ensure_installed = {
      { "bash", "c", "c_sharp", "cmake", "comment", "cpp", "css", "d", "dart" },
      { "dockerfile", "elixir", "elm", "erlang", "fennel", "fish", "go" },
      { "gomod", "graphql", "hcl", "help", "html", "java", "javascript", "jsdoc" },
      { "json", "jsonc", "julia", "kotlin", "latex", "ledger", "lua", "make" },
      { "markdown", "nix", "ocaml", "perl", "php", "python", "query", "r" },
      { "regex", "rego", "ruby", "rust", "scala", "scss", "solidity", "swift" },
      { "teal", "toml", "tsx", "typescript", "vim", "vue", "yaml", "zig" },
    },

    -- ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "haskell", "norg" }, -- List of parsers to ignore installing
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)

    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "org" }, -- list of language that will be disabled
      aditional_vim_regex_highlighting = { "org" },
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "yaml" } },

    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  }
end

return M
