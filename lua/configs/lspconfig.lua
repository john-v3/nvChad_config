-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

vim.lsp.enable({ "html", "cssls", "gopls", "rust_analyzer", "nushell", "powershell_es", "sqls", "omnisharp", "jsonls", "xmlformatter", "angularls"}, true)
vim.lsp.enable({"ts_ls"}, false)

