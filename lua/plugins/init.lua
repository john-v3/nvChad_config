return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "tanvirtin/vgit.nvim",
    branch = "v1.0.x",
    -- or               , tag = 'v1.0.2',
    dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
    -- Lazy loading on 'VimEnter' event is necessary.
    lazy = false,
    -- event = "VimEnter",
    config = function()
      require("vgit").setup()
    end,
  },

  { "OmniSharp/omnisharp-vim", lazy = false },

  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      require("outline").setup {}
    end,
    cmd = { "Outline" },
  },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
