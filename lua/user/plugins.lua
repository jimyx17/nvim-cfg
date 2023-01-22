-- Plugin List
local plugin_list = {
  -- core plugins
  { "folke/lazy.nvim" }, -- Have packer manage itself
  { "nvim-lua/plenary.nvim" }, -- Useful lua functions used by lots of plugins
  { "windwp/nvim-autopairs", event = "InsertEnter" }, -- Autopairs, integrates with both cmp and treesitter
  { "numToStr/Comment.nvim", event = "BufRead" },
  { "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy" },
  { "kyazdani42/nvim-web-devicons" },
  { "kyazdani42/nvim-tree.lua" },
  { "akinsho/bufferline.nvim", tag = "v3.1.0" },
  { "moll/vim-bbye" },
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/toggleterm.nvim" }, -- maybe we might add more than one terminal at a time, not needed now...
  { "ahmedkhalf/project.nvim" },
  { "lukas-reineke/indent-blankline.nvim", tag = "v2.20.2" },
  { "goolord/alpha-nvim" },

  -- Colorschemes
  { "folke/tokyonight.nvim", lazy = true },
  { "lunarvim/darkplus.nvim", name = "darkplus", lazy = true },
  { "LunarVim/lunar.nvim", name = "lunar", lazy = true },
  { "rose-pine/neovim", name = "rose-pine", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  { "rebelot/kanagawa.nvim", name = "kanagawa", lazy = true },
  { "sainnhe/gruvbox-material", lazy = true },
  { "sainnhe/edge", lazy = true },
  { "sainnhe/sonokai", lazy = true },
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = true },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = true },
  { "dracula/vim", name = "dracula", lazy = true },
  { "mhartington/oceanic-next", name = "OceanicNext", lazy = true },
  { "fenetikm/falcon", name = "falcon", lazy = true },
  { "shaunsingh/nord.nvim", name = "nord", lazy = true },
  { "marko-cerovac/material.nvim", name = "material", lazy = true },
  { "EdenEast/nightfox.nvim", name = "nightfox", lazy = true },
  { "projekt0n/github-nvim-theme", name = "github-theme", lazy = true },

  -- cmp plugins
  { "hrsh7th/nvim-cmp", event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "cmp-nvim-lsp", "cmp_luasnip", "cmp-buffer", "cmp-path", "cmp-cmdline" } }, -- The completion plugin
  { "hrsh7th/cmp-buffer", lazy = true }, -- buffer completions
  { "hrsh7th/cmp-path", lazy = true }, -- path completions
  { "hrsh7th/cmp-cmdline", lazy = true }, -- path completions
  { "saadparwaiz1/cmp_luasnip", lazy = true }, -- snippet completions
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  { "hrsh7th/cmp-nvim-lua", lazy = true },

  -- snippets
  { "L3MON4D3/LuaSnip", event = "InsertEnter", dependencies = { "friendly-snippets" } }, --snippet engine
  { "rafamadriz/friendly-snippets", lazy = true }, -- a bunch of snippets to use

  -- LSP
  { "lvimuser/lsp-inlayhints.nvim", lazy = true, config = function()
    require("lsp-inlayhints").setup()
  end },
  { "folke/neodev.nvim", lazy = true },
  { "neovim/nvim-lspconfig", dependencies = { "mason-lspconfig.nvim", "nlsp-settings.nvim" }, lazy = true }, -- enable LSP
  { "williamboman/mason-lspconfig.nvim", lazy = true },
  { "tamago324/nlsp-settings.nvim", lazy = true },
  { "jose-elias-alvarez/null-ls.nvim", lazy = true }, -- for formatters and linters
  { "RRethy/vim-illuminate", lazy = true },
  { "williamboman/mason.nvim", lazy = true },
  { "ray-x/lsp_signature.nvim", lazy = true }, -- Show function signatures
  { "folke/noice.nvim",
    requires = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({ presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      } })
    end }, -- Show function signatures
  { "rcarriga/nvim-notify" },
  { "MunifTanjim/nui.nvim" },

  -- Telescope
  { "nvim-telescope/telescope.nvim", lazy = true, dependencies = { "telescope-fzf-native.nvim" }, cmd = "Telescope" },
  { "nvim-telescope/telescope-fzf-native.nvim", lazy = true },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      local u = require("base.utils")
      local path = u.join_paths(u.get_plugin_image_dir(), "nvim-treesitter")
      vim.opt.rtp:prepend(path)
    end
  },

  -- multi-line
  { "mg979/vim-visual-multi" },

  -- Git annotations. Too much information at editing time?
  -- { "lewis6991/gitsigns.nvim", commit = "f98c85e7c3d65a51f45863a34feb4849c82f240f" }

  -- DAP
  { "mfussenegger/nvim-dap", lazy = true },
  { "rcarriga/nvim-dap-ui", lazy = true },
  { "ravenxrz/DAPInstall.nvim", lazy = true },
  { "Tastyep/structlog.nvim" },

  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      require("crates").setup()
    end,
  },
  {
    "rest-nvim/rest.nvim",
    config = function()
      require("base.rest_http").config()
    end
  },
  { "ThePrimeagen/vim-be-good" },
  -- Measure startup time, not needed for normal use
  { "dstein64/vim-startuptime" },
}


return plugin_list
