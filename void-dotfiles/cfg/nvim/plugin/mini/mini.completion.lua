-- ============================================================================== #
-- Completion:                                                                    #
-- ============================================================================== #
Config.now_if_args(function()
  local MiniCompletion = require('mini.completion')
  MiniCompletion.setup({
    lsp_completion = { source_func = 'omnifunc', auto_setup = false },
    mappings = { force_fallback = '' },
  })
  local on_attach = function(args) vim.bo[args.buf].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp' end
  Config.new_autocmd('LspAttach', { callback = on_attach })

  -- Advertise to servers: =======================================================================
  vim.lsp.config('*', { capabilities = MiniCompletion.get_lsp_capabilities() })
end)
