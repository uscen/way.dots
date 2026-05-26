-- ============================================================================== #
-- Lsp:                                                                           #
-- ============================================================================== #
Config.later(function()
  vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

  -- All language servers are expected to be installed: ==========================================
  vim.lsp.enable({ 'html', 'cssls', 'tailwindcss', 'emmet_language_server', 'vtsls', 'jsonls', 'lua_ls' })
end)
