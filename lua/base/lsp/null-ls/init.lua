local M = {}


M.config = function()
  local nls = require("null-ls")
  local u = require("base.utils")

  local vale_config = u.join_paths(vim.env.HOME, ".vale.ini")
  local semgrep_rule_folder = u.join_paths( vim.env.HOME, ".config", "semgrep", "semgrep-rules")
  local use_semgrep = false
  if vim.fn.filereadable(u.join_paths(semgrep_rule_folder, "template.yaml")) then
    use_semgrep = true
  end

  -- local custom_go_actions = require "user.null_ls.go"
  -- local custom_md_hover = require "user.null_ls.markdown"
  --
  local sources = {
    -- NOTE: npm install -g prettier prettier-plugin-solidity
    nls.builtins.formatting.prettier.with {
      filetypes = { "solidity" },
      timeout = 10000,
    },
    nls.builtins.formatting.prettierd.with {
      condition = function(utils)
        return not utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.formatting.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = u.join_paths("node_modules", ".bin"),
    },
    nls.builtins.formatting.stylua,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.gofumpt,
    nls.builtins.formatting.cmake_format,
    nls.builtins.formatting.scalafmt,
    nls.builtins.formatting.sqlformat,
    nls.builtins.formatting.terraform_fmt,
    -- Support for nix files
    nls.builtins.formatting.alejandra,
    nls.builtins.formatting.shfmt.with { extra_args = { "-i", "2", "-ci" } },
    nls.builtins.formatting.black.with { extra_args = { "--fast" }, filetypes = { "python" } },
    nls.builtins.formatting.isort.with { extra_args = { "--profile", "black" }, filetypes = { "python" } },
    nls.builtins.diagnostics.ansiblelint.with {
      condition = function(utils)
        return utils.root_has_file "roles" and utils.root_has_file "inventories"
      end,
    },
    nls.builtins.diagnostics.solhint.with {
      condition = function(utils)
        return utils.root_has_file ".solhint.json"
      end,
    },
    nls.builtins.diagnostics.hadolint,
    nls.builtins.diagnostics.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = "node_modules/.bin",
    },
    nls.builtins.diagnostics.semgrep.with {
      condition = function(utils)
        return utils.root_has_file ".semgrepignore" and use_semgrep
      end,
      extra_args = { "--metrics", "off", "--exclude", "vendor", "--config", semgrep_rule_folder },
    },
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.diagnostics.luacheck,
    nls.builtins.diagnostics.vint,
    nls.builtins.diagnostics.chktex,
    -- Support for nix files
    nls.builtins.diagnostics.deadnix,
    nls.builtins.diagnostics.statix,
    nls.builtins.diagnostics.markdownlint.with {
      filetypes = { "markdown" },
      extra_args = { "-r", "~MD013" },
    },
    nls.builtins.diagnostics.vale.with {
      filetypes = { "markdown" },
      extra_args = { "--config", vale_config },
    },
    nls.builtins.diagnostics.revive.with {
      condition = function(utils)
        return utils.root_has_file "revive.toml"
      end,
    },
    nls.builtins.code_actions.shellcheck,
    nls.builtins.code_actions.gomodifytags,
    nls.builtins.code_actions.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
      end,
      prefer_local = u.join_paths("node_modules", ".bin"),
    },
    -- TODO: try these later on
    -- nls.builtins.formatting.google_java_format,
    -- nls.builtins.code_actions.proselint,
    -- nls.builtins.diagnostics.proselint,
    -- custom_go_actions.gostructhelper,
    -- custom_md_hover.dictionary,
  }
  -- if vim.builtin.refactoring.active then
  table.insert(
    sources,
    nls.builtins.code_actions.refactoring.with {
      filetypes = { "typescript", "javascript", "lua", "c", "cpp", "go", "python", "java", "php" },
    }
  )
  -- end
  local ts_found, typescript_code_actions = pcall(require, "typescript.extensions.null-ls.code-actions")
  if ts_found then
    table.insert(sources, typescript_code_actions)
  end
  vim.lsp.null_ls.setup.sources = sources
end


function M.setup()
  local null_ls = require("null-ls")

  local default_opts = require("base.lsp").get_common_opts()
  null_ls.setup(vim.tbl_deep_extend("force", default_opts, vim.lsp.null_ls.setup))
end

return M
