-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "everblush",
  transparency = true,

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },
  integrations = { "dap", "hop" },
}

M.mason = {
  pkgs = {
    "revive",
    "docker-language-server",
    "go-debug-adapter",
    "json-lsp",
    "lua-language-server",
    "markuplint",
    "omnisharp",
    "rust-analyzer",
    "json-lsp",
    "xmlformatter",
    "angular-language-server",
    "typescript-language-server",
  },
  Skip = {},
}

return M
