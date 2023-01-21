local M = {}

local check_backspace = function()
  local col = vim.fn.col "." - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
end

local cmp_sources = {
  ["vim-dadbod-completion"] = "(DadBod)",
  buffer = "(Buffer)",
  cmp_tabnine = "(TabNine)",
  crates = "(Crates)",
  latex_symbols = "(LaTeX)",
  nvim_lua = "(NvLua)",
}

function M.setup()
  local cmp = require("cmp")
  local icons = require("user.ascii_icons")
  local luasnip = require("luasnip")
  require("luasnip.loaders.from_vscode").lazy_load()
  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    mapping = cmp.mapping.preset.insert {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
      ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
      ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
      ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      },
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expandable() then
          luasnip.expand()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif check_backspace() then
          fallback()
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    },
    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        if entry.source.name == "cmdline" then
          vim_item.kind = "⌘"
          vim_item.menu = ""
          return vim_item
        end
        vim_item.menu = cmp_sources[entry.source.name] or vim_item.kind
        vim_item.kind = icons.cmp_kind[vim_item.kind] or vim_item.kind
        return vim_item
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "path" },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    experimental = {
      ghost_text = true,
    },
  }

  cmp.setup.filetype("toml", {
    sources = cmp.config.sources({
      {
        name = "nvim_lsp",
        max_item_count = 8,
      },
      {
        name = "crates",
      },
      {
        name = "luasnip",
        max_item_count = 5,
      },
    }, { {
      name = "buffer",
      max_item_count = 5,
      keyword_length = 5,
    } }),
  })

  cmp.setup.filetype("tex", {
    sources = cmp.config.sources({
      {
        name = "latex_symbols",
        max_item_count = 3,
        keyword_length = 3,
      },
      {
        name = "nvim_lsp",
        max_item_count = 8,
      },
      {
        name = "luasnip",
        max_item_count = 5,
      },
    }, { {
      name = "buffer",
      max_item_count = 5,
      keyword_length = 5,
    } }),
  })
end

return M
