-- ============================================================================== #
-- Completion:                                                                    #
-- ============================================================================== #
Config.now_if_args(function()
  local MiniCompletion = require('mini.completion')
  local process_items_opts = { kind_priority = { Text = -1, Snippet = 99 } }
  local process_items = function(items, base)
    return MiniCompletion.default_process_items(items, base, process_items_opts)
  end
  MiniCompletion.setup({
    fallback_action = '<C-n>',
    delay = { completion = 100, info = 100, signature = 50 },
    window = { info = { border = 'single' }, signature = { border = 'single' } },
    mappings = { force_twostep = '<C-n>', force_fallback = '<C-S-n>', scroll_down = '<C-f>', scroll_up = '<C-b>' },
    lsp_completion = { source_func = 'omnifunc', auto_setup = false, process_items = process_items },
  })
  local on_attach = function(args) vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp" end
  Config.new_autocmd("LspAttach", { callback = on_attach })
  vim.lsp.config('*', { capabilities = vim.lsp.protocol.make_client_capabilities()})
end)
