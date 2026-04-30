-- ============================================================================== #
-- Lsp:                                                                           #
-- ============================================================================== #
Config.later(function()
  vim.lsp.enable({ 'html', 'cssls', 'emmet_ls', 'vtsls', 'jsonls', 'yamlls', 'lua_ls' })
  vim.lsp.config('*', { capabilities = vim.lsp.protocol.make_client_capabilities() })
  Config.new_autocmd('LspAttach', {
    callback = function(ev)
      local bufnr = ev.buf
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client then
        return
      end

      -- Completion support: =====================================================================
      if client:supports_method('textDocument/completion', bufnr) then
        vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
      end

      -- Inline completion: ======================================================================
      if client:supports_method('textDocument/inlineCompletion', bufnr) then
        vim.lsp.inline_completion.enable(true)
      end

      -- Linked editing (e.g., paired HTML tags):
      if client:supports_method('textDocument/linkedEditingRange', bufnr) then
        vim.lsp.linked_editing_range.enable(true, { bufnr = bufnr })
      end

      -- Inline color swatches: ==================================================================
      if client:supports_method('textDocument/documentColor', bufnr) then
        vim.lsp.document_color.enable(true, { bufnr = bufnr })
      end

      -- Disable codelens for lua (lua_ls "0 References" is noisy): ==============================
      if client.name == 'lua_ls' then
        vim.lsp.codelens.enable(false, { bufnr = bufnr })
      end

      -- Set the keymaps: ==========================================================================
      if client:supports_method('textDocument/hover', bufnr) then
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      end

      if client:supports_method('textDocument/definition', bufnr) then
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr })
      end

      if client:supports_method('textDocument/declaration', bufnr) then
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
      end

      if client:supports_method('textDocument/implementation', bufnr) then
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr })
      end

      if client:supports_method('textDocument/references', bufnr) then
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr })
      end

      if client:supports_method('textDocument/codeAction', bufnr) then
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = bufnr })
      end

      if client:supports_method('textDocument/rename', bufnr) then
        vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { buffer = bufnr })
      end

      if client:supports_method('textDocument/typeDefinition', bufnr) then
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = bufnr })
      end

      if client:supports_method('textDocument/signatureHelp', bufnr) then
        vim.keymap.set('n', 'go', vim.lsp.buf.signature_help, { buffer = bufnr })
      end

      if client:supports_method('textDocument/documentSymbol', bufnr) then
        vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, { buffer = bufnr })
      end

      if client:supports_method('workspace/symbol') then
        if pcall(require, 'mini.pick', bufnr) then
          vim.keymap.set('n', 'gS', '<Cmd>Pick lsp scope="document_symbol"<cr>', { buffer = bufnr })
        end
      end

      if client:supports_method('textDocument/prepareCallHierarchy') then
        if client:supports_method('callHierarchy/incomingCalls') then
          vim.keymap.set('n', 'g(', function() vim.lsp.buf.incoming_calls() end, { buffer = bufnr })
        end
        if client:supports_method('callHierarchy/outgoingCalls') then
          vim.keymap.set('n', 'g)', function() vim.lsp.buf.outgoing_calls() end, { buffer = bufnr })
        end
      end

      if client:supports_method('textDocument/inlayHint', bufnr) then
        vim.keymap.set('n', 'yoh', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          vim.notify(string.format('Show inlay hints set to %s', vim.lsp.inlay_hint.is_enabled()), vim.log.INFO)
        end, { buffer = true })
      end
    end,
  })
end)
