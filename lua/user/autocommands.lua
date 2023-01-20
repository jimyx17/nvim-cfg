local M = {}

local Log = require("log")

--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
  -- defer the function in case the autocommand is still in-use
  Log:debug("request to clear autocmds  " .. name)
  vim.schedule(function()
    pcall(function()
      vim.api.nvim_clear_autocmds { group = name }
    end)
  end)
end

local get_format_on_save_opts = function()
  return {
    enabled = false,
    patterh = "*",
    timeout = 1000,
    filter = require("user.lsp.utils").format_filter
  }
end

function M.enable_format_on_save()
  local opts = get_format_on_save_opts()
  vim.api.nvim_create_augroup("lsp_format_on_save", {})
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = "lsp_format_on_save",
    pattern = opts.pattern,
    callback = function()
      require("user.lsp.utils").format { timeout_ms = opts.timeout, filter = opts.filter }
    end,
  })
  Log:debug "enabled format-on-save"
end

function M.disable_format_on_save()
  M.clear_augroup "lsp_format_on_save"
  Log:debug "disabled format-on-save"
end

function M.configure_format_on_save()
  if vim.g.format_on_save == true then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

function M.toggle_format_on_save()
  local exists, autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = "lsp_format_on_save",
    event = "BufWritePre",
  })
  if not exists or #autocmds == 0 then
    M.enable_format_on_save()
  else
    M.disable_format_on_save()
  end
end

--- Setup autocommands
function M.setup()
  --Filetype autocommands
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
    callback = function()
      vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR> 
      set nobuflisted 
    ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })

  vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

  vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
      vim.cmd "tabdo wincmd ="
    end,
  })

  vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
    callback = function()
      vim.cmd "quit"
    end,
  })

  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    callback = function()
      vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { "*.java" },
    callback = function()
      vim.lsp.codelens.refresh()
    end,
  })

  vim.api.nvim_create_autocmd({ "VimEnter" }, {
    callback = function()
      vim.cmd "hi link illuminatedWord LspReferenceText"
    end,
  })

  vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
    callback = function()
      local line_count = vim.api.nvim_buf_line_count(0)
      if line_count >= 5000 then
        vim.cmd "IlluminatePauseBuf"
      end
    end,
  })

  vim.api.nvim_create_augroup("_general_settings", {})
  vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = "_general_settings",
    pattern = "*",
    desc = "Highlight text on yank",
    callback = function()
      vim.highlight.on_yank { higroup = "Search", timeout = 100 }
    end,
  })

  vim.api.nvim_create_augroup("_hide_dap_repl", {})
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "_hide_dap_repl",
    pattern = "dap-repl",
    command = "set nobuflisted",
  })

  vim.api.nvim_create_augroup("_filetype_settings", {})
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "_filetype_settings",
    pattern = { "lua" },
    desc = "fix gf functionality inside .lua files",
    callback = function()
      ---@diagnostic disable: assign-type-mismatch
      -- credit: https://github.com/sam4llis/nvim-lua-gf
      vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
      vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
      vim.opt_local.suffixesadd:prepend ".lua"
      vim.opt_local.suffixesadd:prepend "init.lua"

      for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
        vim.opt_local.path:append(path .. "/lua")
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "_filetype_settings",
    pattern = "alpha",
    callback = function()
      vim.cmd [[
            nnoremap <silent> <buffer> q :qa<CR>
            nnoremap <silent> <buffer> <esc> :qa<CR>
            set nobuflisted
          ]]
    end,
  })

  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "_filetype_settings",
    pattern = "lir",
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
    end,
  })

  vim.api.nvim_create_augroup("_buffer_mappings", {})
  vim.api.nvim_create_autocmd({ "FileType" }, {
    group = "_buffer_mappings",
    pattern = {
      "qf",
      "help",
      "man",
      "floaterm",
      "lspinfo",
      "lir",
      "lsp-installer",
      "null-ls-info",
      "tsplayground",
      "DressingSelect",
      "Jaq",
    },
    callback = function()
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true })
      vim.opt_local.buflisted = false
    end,
  })

  vim.api.nvim_create_augroup("_auto_resize", {})
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    group = "_auto_resize",
    pattern = "*",
    command = "tabdo wincmd =",
  })

  vim.api.nvim_create_augroup("_colorscheme", {})
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    group = "_colorscheme",
    callback = function()
      local statusline_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
      local cursorline_hl = vim.api.nvim_get_hl_by_name("CursorLine", true)
      local normal_hl = vim.api.nvim_get_hl_by_name("Normal", true)
      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
      vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
      vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
      vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
      vim.api.nvim_set_hl(0, "SLCopilot", { fg = "#6CC644", bg = statusline_hl.background })
      vim.api.nvim_set_hl(0, "SLGitIcon", { fg = "#E8AB53", bg = cursorline_hl.background })
      vim.api.nvim_set_hl(0, "SLBranchName", { fg = normal_hl.foreground, bg = cursorline_hl.background })
      vim.api.nvim_set_hl(0, "SLSeparator", { fg = cursorline_hl.background, bg = statusline_hl.background })
    end,
  })

  vim.api.nvim_create_augroup("_lsp_installer", {})
  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "StdinReadPost" }, {
    group = "_lsp_installer",
    callback = function(args)
      Log:debug("CALLED AUTOCOMMAND")
      local ft = vim.bo.filetype
      if not ft then
        ft, _ = vim.filetype.match({ filename = args.match, buf = args.buf })
      end
      if not ft then
        ft = require('vim.filetype.detect').conf(args.file, args.buf)
      end
      pcall(function()
        local server_names = require("mason-lspconfig").get_available_servers({ filetype = ft })
        Log:debug(vim.inspect(server_names))
        for _, server in pairs(server_names) do
          require("user.lsp.manager").setup(server)
        end
      end)
    end
  })

end

return M
