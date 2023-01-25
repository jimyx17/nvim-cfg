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
      additional_vim_regex_highlighting = false,
      disable = function(lang, buf)
        if vim.tbl_contains({ "latex" }, lang) then
          return true
        end

        local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
        return status_ok and big_file_detected
      end,
    },
    autopairs = {
      enable = true,
    },
    indent = { enable = true, disable = { "python", "yaml" } },
    autotag = { enable = false },
    textobjects = {
      swap = {
        enable = false,
        -- swap_next = textobj_swap_keymaps,
      },
      -- move = textobj_move_keymaps,
      select = {
        enable = false,
        -- keymaps = textobj_sel_keymaps,
      },
    },
    textsubjects = {
      enable = false,
      keymaps = { ["."] = "textsubjects-smart", [";"] = "textsubjects-big" },
    },
    playground = {
      enable = false,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = "o",
        toggle_hl_groups = "i",
        toggle_injected_languages = "t",
        toggle_anonymous_nodes = "a",
        toggle_language_display = "I",
        focus_language = "f",
        unfocus_language = "F",
        update = "R",
        goto_node = "<cr>",
        show_help = "?",
      },
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
      config = {
        -- Languages that have a single comment style
        typescript = "// %s",
        css = "/* %s */",
        scss = "/* %s */",
        html = "<!-- %s -->",
        svelte = "<!-- %s -->",
        vue = "<!-- %s -->",
        json = "",
      },
    },
    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = 1000
    }
  }
end

return M
