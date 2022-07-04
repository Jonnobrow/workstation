local ok, util = pcall(require, 'lspconfig.util')
if not ok then
  return
end

local lsp_signature = require 'lsp_signature'
local null_ls = require 'null-ls'
local saga = require 'lspsaga'
saga.init_lsp_saga()

vim.api.nvim_create_user_command('LspLog', [[exe 'tabnew ' .. luaeval("vim.lsp.get_log_path()")]], {})

require('nvim-lsp-installer').setup {
  automatic_installation = true,
  log_level = vim.log.levels.DEBUG,
  ui = {
    check_outdated_servers_on_open = false,
    icons = {
      server_installed = '',
      server_pending = '',
      server_uninstalled = '',
    },
  },
}

local cmp_lsp = require 'cmp_nvim_lsp'

---@param opts table|nil
local function create_capabilities(opts)
  local default_opts = {
    with_snippet_support = true,
  }
  opts = opts or default_opts
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = opts.with_snippet_support
  if opts.with_snippet_support then
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    }
  end
  return cmp_lsp.update_capabilities(capabilities)
end

local function highlight_references()
  while node ~= nil do
    local node_type = node:type()
    if
      node_type == 'string'
      or node_type == 'string_fragment'
      or node_type == 'template_string'
      or node_type == 'document' -- for inline gql`` strings
    then
      -- who wants to highlight a string? i don't. yuck
      return
    end
    node = node:parent()
  end
  vim.lsp.buf.document_highlight()
end

--- @return fun() @function that calls the provided fn, but with no args
local function w(fn)
  return function()
    return fn()
  end
end

---@param bufnr number
local function buf_autocmd_document_highlight(bufnr)
  local group = vim.api.nvim_create_augroup('lsp_document_highlight', {})
  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
    buffer = bufnr,
    group = group,
    callback = highlight_references,
  })
  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.buf.clear_references),
  })
end

---@param bufnr number
local function buf_autocmd_codelens(bufnr)
  local group = vim.api.nvim_create_augroup('lsp_document_codelens', {})
  vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'BufWritePost', 'CursorHold' }, {
    buffer = bufnr,
    group = group,
    callback = w(vim.lsp.codelens.refresh),
  })
end

-- Finds and runs the closest codelens (searches upwards only)
local function find_and_run_codelens()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local lenses = vim.lsp.codelens.get(bufnr)

  lenses = vim.tbl_filter(function(lense)
    return lense.range.start.line < row
  end, lenses)

  if #lenses == 0 then
    return vim.notify 'Could not find codelens to run.'
  end

  table.sort(lenses, function(a, b)
    return a.range.start.line > b.range.start.line
  end)

  vim.api.nvim_win_set_cursor(0, { lenses[1].range.start.line + 1, lenses[1].range.start.character })
  vim.lsp.codelens.run()
  vim.api.nvim_win_set_cursor(0, { row, col }) -- restore cursor, TODO: also restore position
end

---@param bufnr number
local function buf_set_keymaps(bufnr)
  local wk = require 'which-key'
  wk.register({
    g = {
      name = '+goto',
      D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Declaration' },
      d = { "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", 'Definitions' },
      r = { '<cmd>Trouble lsp_references<cr>', 'References' },
      I = { "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", 'Implementations' },
    },
    ['<leader>l'] = {
      name = '+lsp',
      f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
      r = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
      a = { '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', 'Code Action' },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>", 'Symbols' },
      d = { '<cmd>Trouble workspace_diagnostics<cr>', 'Diagnostics' },
      ['bd'] = { '<cmd>Trouble document_diagnostics<cr>', 'Buffer Diagnostics' },
      l = {
        function()
          find_and_run_codelens()
        end,
        'Code Lens',
      },
    },
    ['<M-p>'] = { '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>', 'Signature Help' },
    K = { '<cmd>lua require"lspsaga.hover".render_hover_doc()<cr>', 'Hover' },
  }, { buffer = bufnr })
  wk.register({
    ['<leader>la'] = { '<cmd>lua require("lspsaga.codeaction").range_code_action()<cr>', 'Code Action' },
  }, { mode = 'v', buffer = bufnr })
  wk.register({
    ['<M-p>'] = { '<cmd>lua require("lspsaga.signaturehelp").signature_help()<cr>', 'Signature Help' },
  }, { mode = 'i', buffer = bufnr })
end

local function common_on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  buf_set_keymaps(bufnr)

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  if client.supports_method 'textDocument/documentHighlight' then
    buf_autocmd_document_highlight(bufnr)
  end

  if client.supports_method 'textDocument/codeLens' then
    buf_autocmd_codelens(bufnr)
    vim.schedule(vim.lsp.codelens.refresh)
  end

  lsp_signature.on_attach({
    bind = true,
    floating_window = false,
    hint_prefix = '',
    hint_scheme = 'Comment',
  }, bufnr)
end

util.on_setup = util.add_hook_after(util.on_setup, function(config)
  if config.on_attach then
    config.on_attach = util.add_hook_after(config.on_attach, common_on_attach)
  else
    config.on_attach = common_on_attach
  end
  config.capabilities = create_capabilities()
end)

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.alex,
    null_ls.builtins.diagnostics.ansiblelint,
--   null_ls.builtins.diagnostics.codespell,
    null_ls.builtins.diagnostics.proselint,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.hover.dictionary,
  },
  on_attach = common_on_attach,
}
