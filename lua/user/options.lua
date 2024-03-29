local M = {}

local u = require "base.utils"
local ascii_icons = require "user.ascii_icons"

function M.setup()
  vim.opt.backup = false -- creates a backup file
  vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
  vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
  vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
  vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
  vim.opt.fileencoding = "utf-8" -- the encoding written to a file
  vim.opt.hlsearch = true -- highlight all matches on previous search pattern
  vim.opt.ignorecase = true -- ignore case in search patterns
  vim.opt.mouse = "a" -- allow the mouse to be used in neovim
  vim.opt.pumheight = 10 -- pop up menu height
  vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
  vim.opt.showtabline = 0 -- always show tabs
  vim.opt.smartcase = true -- smart case
  vim.opt.smartindent = true -- make indenting smarter again
  vim.opt.splitbelow = true -- force all horizontal splits to go below current window
  vim.opt.splitright = true -- force all vertical splits to go to the right of current window
  vim.opt.swapfile = false -- creates a swapfile
  vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
  vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
  vim.opt.undofile = true -- enable persistent undo
  vim.opt.updatetime = 300 -- faster completion (4000ms default)
  vim.opt.writebackup = true -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  vim.opt.expandtab = true -- convert tabs to spaces
  vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
  vim.opt.tabstop = 2 -- insert 2 spaces for a tab
  vim.opt.cursorline = true -- highlight the current line
  vim.opt.number = true -- set numbered lines
  vim.opt.relativenumber = true -- show relative number instead of absolute number
  vim.opt.laststatus = 3 -- only the last window will always have a status line
  vim.opt.showcmd = false -- hide (partial) command in the last line of the screen (for performance)
  vim.opt.ruler = false -- hide the line and column number of the cursor position
  vim.opt.numberwidth = 4 -- minimal number of columns to use for the line number {default 4}
  vim.opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
  vim.opt.wrap = false -- display lines as one long line
  vim.opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
  vim.opt.sidescrolloff = 8 -- minimal number of screen columns to keep to the left and right of the cursor if wrap is `false`
  vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
  vim.opt.fillchars.eob = " " -- show empty lines at the end of a buffer as ` ` {default `~`}
  vim.opt.shortmess:append "c" -- hide all the completion messages, e.g. "-- XXX completion (YYY)", "match 1 of 2", "The only match", "Pattern not found"
  vim.opt.whichwrap:append "<,>,[,],h,l" -- keys allowed to move to the previous/next line when the beginning/end of line is reached
  vim.opt.iskeyword:append "-" -- treats words with `-` as single words
  vim.opt.formatoptions:remove { "c", "r", "o" } -- This is a sequence of letters which describes how automatic formatting is to be done
  vim.opt.linebreak = true
  vim.log.level = "INFO"
  -- Custom configuration
  vim.g.format_on_save = true
  -- Theme
  vim.g.theme = "kanagawa"

  -- Diagnostics
  local signs = {
    { name = "DiagnosticSignError", text = ascii_icons.icons.error },
    { name = "DiagnosticSignWarn", text = ascii_icons.icons.warn },
    { name = "DiagnosticSignHint", text = ascii_icons.icons.hint },
    { name = "DiagnosticSignInfo", text = ascii_icons.icons.info },
  }

  local float_text = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
    format = function(d)
      local code = d.code or (d.user_data and d.user_data.lsp.code)
      if code then
        return string.format("%s [%s]", d.message, code):gsub("1. ", "")
      end
      return d.message
    end,
  }

  vim.diagnostic.config {
    virtual_text = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    signs = signs,
    float = float_text,
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  -- LSP
  vim.lsp.buffer_mappings = {
    normal_mode = {
      ["K"] = { vim.lsp.buf.hover, "Show hover" },
      ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
      ["gD"] = { vim.lsp.buf.declaration, "Goto declaration" },
      ["gr"] = { vim.lsp.buf.references, "Goto references" },
      ["gI"] = { vim.lsp.buf.implementation, "Goto Implementation" },
      ["gs"] = { vim.lsp.buf.signature_help, "show signature help" },
      ["gl"] = {
        function()
          -- local config = float_text
          local config = {}
          config.scope = "line"
          vim.diagnostic.open_float(config)
        end,
        "Show line diagnostics",
      },
      ["ge"] = {
        function()
          -- local config = float_text
          local config = {}
          config.scope = "line"
          vim.diagnostic.goto_next(config)
        end,
        "Go to next line diagnostics",
      },
      ["gE"] = {
        function()
          -- local config = float_text
          local config = {}
          config.scope = "line"
          vim.diagnostic.goto_prev(config)
        end,
        "Go to next line diagnostics",
      },
    },
    insert_mode = {},
    visual_mode = {},
  }
  vim.lsp.buffer_options = {
    omnifunc = "v:lua.vim.lsp.omnifunc",
    formatexpr = "v:lua.vim.lsp.formatexpr(#{timeout_ms:500})",
  }
  vim.lsp.automatic_configuration = {
    skipped_servers = {
      "angularls",
      "ansiblels",
      "ccls",
      "csharp_ls",
      "cssmodules_ls",
      "denols",
      "ember",
      "emmet_ls",
      "eslint",
      "eslintls",
      "glint",
      "golangci_lint_ls",
      "gradle_ls",
      "graphql",
      "jedi_language_server",
      "ltex",
      "neocmake",
      "ocamlls",
      "phpactor",
      "psalm",
      "pylsp",
      "quick_lint_js",
      "reason_ls",
      "rnix",
      "rome",
      "ruby_ls",
      "ruff_lsp",
      "scry",
      "solang",
      "solc",
      "solidity_ls",
      "sorbet",
      "sourcekit",
      "sourcery",
      "spectral",
      "sqlls",
      "sqls",
      "stylelint_lsp",
      "svlangserver",
      "tflint",
      "verible",
      "vuels",
    },
    skipped_filetypes = { "markdown", "rst", "plaintext", "toml", "proto" },
  }
  vim.lsp.installer = {
    setup = {
      ensure_installed = {},
      automatic_installation = {
        exclude = {},
      },
    },
  }
  vim.lsp.null_ls = {
    setup = {
      debounce = 150,
      save_after_format = false,
    },
  }
  vim.lsp.nlsp_settings = {
    setup = {
      config_home = u.join_paths(u.get_config_dir(), "lsp-settings"),
      -- set to false to overwrite schemastore.nvim
      append_default_schemas = true,
      ignored_servers = {},
      loader = "json",
    },
  }
end

return M
