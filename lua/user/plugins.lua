local fn = vim.fn
local utils = require("utils")

-- Plugin List
local plugin_list = {
  -- core plugins
  { "folke/lazy.nvim"}, -- Have packer manage itself
  { "nvim-lua/plenary.nvim"}, -- Useful lua functions used by lots of plugins
  { "windwp/nvim-autopairs", event = "InsertEnter"}, -- Autopairs, integrates with both cmp and treesitter
  { "numToStr/Comment.nvim", event = "BufRead"},
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy"},
  { "kyazdani42/nvim-web-devicons"},
  { "kyazdani42/nvim-tree.lua"},
  { "akinsho/bufferline.nvim", tag = "v3.1.0"},
  { "moll/vim-bbye"},
  { "nvim-lualine/lualine.nvim"},
  { "akinsho/toggleterm.nvim"}, -- maybe we might add more than one terminal at a time, not needed now...
  { "ahmedkhalf/project.nvim"},
  { "lukas-reineke/indent-blankline.nvim", tag = "v2.20.2"},
  { "goolord/alpha-nvim"},

  -- Colorschemes
  { "folke/tokyonight.nvim"},
  { "lunarvim/darkplus.nvim"},
  { "LunarVim/lunar.nvim"},

  -- cmp plugins
  { "hrsh7th/nvim-cmp", event = {"InsertEnter", "CmdlineEnter"}, dependencies = { "cmp-nvim-lsp", "cmp_luasnip", "cmp-buffer", "cmp-path", "cmp-cmdline"}}, -- The completion plugin
  { "hrsh7th/cmp-buffer", lazy = true}, -- buffer completions
  { "hrsh7th/cmp-path", lazy = true}, -- path completions
  { "hrsh7th/cmp-cmdline", lazy = true}, -- path completions
  { "saadparwaiz1/cmp_luasnip", lazy = true}, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", lazy = true},
  { "hrsh7th/cmp-nvim-lua", lazy = true},

  -- snippets
  { "L3MON4D3/LuaSnip", event = "InsertEnter", dependencies = {"friendly-snippets"}}, --snippet engine
  { "rafamadriz/friendly-snippets", lazy = true}, -- a bunch of snippets to use

  -- LSP
  -- use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  { "folke/neodev.nvim", lazy = true},
  { "neovim/nvim-lspconfig", dependencies = {"mason-lspconfig.nvim", "nlsp-settings.nvim"}, lazy = true}, -- enable LSP
  { "williamboman/mason-lspconfig.nvim", lazy = true},
  { "tamago324/nlsp-settings.nvim", lazy = true},
  { "jose-elias-alvarez/null-ls.nvim", lazy = true}, -- for formatters and linters
  { "RRethy/vim-illuminate"},

  { "williamboman/mason.nvim"},

  -- Telescope
  { "nvim-telescope/telescope.nvim", lazy = true, dependecies = {"telescope-fzf-native.nvim"}, cmd = "Telescope"},

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function ()
      local u = require("utils")
      local path = u.join_paths(u.get_plugin_image_dir(), "nvim-treesitter")
      vim.opt.rtp:prepend(path)
    end

  },

  -- Git annotations. Too much information at editing time?
  -- { "lewis6991/gitsigns.nvim", commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" }

  -- DAP
  { "mfussenegger/nvim-dap", lazy = true},
  { "rcarriga/nvim-dap-ui", lazy = true},
  { "ravenxrz/DAPInstall.nvim", lazy = true},
  { "Tastyep/structlog.nvim" },
}

vim.g.pkg_mgr.update_plugin_list(plugin_list)
