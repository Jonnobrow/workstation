local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
  return
end

lspconfig.jsonls.setup {
  settings = {
    json = {
      hover = true,
      completion = true,
      validate = true,
      schemas = require('schemastore').json.schemas(),
    },
  },
}
