-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "gopls", "rust_analyzer", "nushell", "powershell_es", "sqls", "omnisharp" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.powershell_es.setup {
  bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services/PowerShellEditorServices",
  shell = "pwsh",
  cmd = {
    "pwsh",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
  },
}

local pid = vim.fn.getpid()
local omnisharp_bin = "c:/program files/omnisharp/omnisharp.exe"

lspconfig.omnisharp.setup {
  cmd = {
    omnisharp_bin,
    "--languageserver",
    "--hostpid",
    tostring(pid),
  },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}
