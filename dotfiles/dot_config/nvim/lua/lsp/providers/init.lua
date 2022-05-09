local servers = {
  "ansiblels",
  "bashls",
  "dockerls",
  "gopls",
  "groovyls",
  "html",
  "jsonls",
  "puppet",
  "pyright",
  "sumneko_lua",
  "terraformls",
  "tflint",
  "yamlls",
}
require('nvim-lsp-installer').setup({
  ensure_installed = servers,
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = '✓',
      server_pending = '➜',
      server_uninstalled = '✗',
    },
  },
})
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  --require('lsp.maps').init(client, bufnr)
end
for _, lsp in pairs(servers) do
  local lspconfig = require('lspconfig')
  local hasmod, _ = pcall(require, 'lsp.providers.' .. lsp)
  if hasmod then
    if lsp == 'sumneko_lua' then -- Language Servers whose inbuilt formatter I don't want to use
      lspconfig[lsp].setup({
        on_attach = function(client, bufnr)
          client.resolved_capabilities.document_formatting = false
          client.resolved_capabilities.document_range_formatting = false
          on_attach(client, bufnr)
        end,
        settings = require('lsp.providers.' .. lsp),
      })
    else
      lspconfig[lsp].setup({ on_attach = on_attach, settings = require('lsp.providers.' .. lsp) })
    end
  else
    lspconfig[lsp].setup({ on_attach = on_attach })
  end
end
