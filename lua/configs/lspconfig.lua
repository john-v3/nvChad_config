-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

vim.lsp.enable({ "html", "cssls", "gopls", "rust_analyzer", "nushell", "powershell_es", "sqls", "omnisharp", "jsonls", "xmlformatter", "angularls"}, true)
vim.lsp.enable({"ts_ls"}, false)

vim.diagnostic.config {
  -- Use the default configuration
  virtual_lines = true,

  virtual_text = false,
  -- Alternatively, customize specific options
  -- virtual_lines = {
  --  -- Only show virtual line diagnostics for the current cursor line
  --  current_line = true,
  -- },
}

