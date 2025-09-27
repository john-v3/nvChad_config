-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

vim.lsp.enable({ "html", "cssls", "gopls", "rust_analyzer", "nushell", "powershell_es", "sqls", "omnisharp" }, true)
local nvlsp = require "nvchad.configs.lspconfig"

vim.lsp.config("powershell_es", {
  bundle_path = "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services/PowerShellEditorServices",
  shell = "pwsh",
  cmd = {
    "pwsh",
    "-NoLogo",
    "-NoProfile",
    "-Command",
    "~/AppData/Local/nvim-data/mason/packages/powershell-editor-services/PowerShellEditorServices/Start-EditorServices.ps1",
  },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})


-- omnisharp requires a mason installation of omnisharp, and dotnet to be added to your env path for invocation 
