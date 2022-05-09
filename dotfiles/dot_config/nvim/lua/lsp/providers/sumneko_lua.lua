local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
return {
  Lua = {
    runtime = {
      version = 'LuaJIT',
      path = runtime_path,
    },
    telemetry = {
      enable = false,
    },
    format = {
      enable = false,
    },
    diagnostics = {
      globals = { 'vim' },
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file('', true),
    },
  },
}