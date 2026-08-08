-- ============================================================================== #
-- Typescript:                                                                    #
-- ============================================================================== #
---@type vim.lsp.Config
return {
  cmd = { 'tsgo', '--lsp', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { '.git', 'tsconfig.json', 'tsconfig.base.json', 'jsconfig.json', 'package.json' },
}
