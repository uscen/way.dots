-- ============================================================================== #
-- Lsp:                                                                           #
-- ============================================================================== #
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then
      return
    end

    -- Completion support: =======================================================================
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
    end

    -- Set the keymaps: ==========================================================================
    if client:supports_method('textDocument/hover') then
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = true })
    end

    if client:supports_method('textDocument/definition') then
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = true })
    end

    if client:supports_method('textDocument/declaration') then
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = true })
    end

    if client:supports_method('textDocument/implementation') then
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = true })
    end

    if client:supports_method('textDocument/references') then
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = true })
    end

    if client:supports_method('textDocument/codeAction') then
      vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = true })
    end

    if client:supports_method('textDocument/rename') then
      vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { buffer = true })
    end

    if client:supports_method('textDocument/typeDefinition') then
      vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { buffer = true })
    end

    if client:supports_method('textDocument/signatureHelp') then
      vim.keymap.set('n', 'go', vim.lsp.buf.signature_help, { buffer = true })
    end

    if client:supports_method('textDocument/documentSymbol') then
      vim.keymap.set('n', 'gs', vim.lsp.buf.document_symbol, { buffer = true })
    end

    if client:supports_method('workspace/symbol') then
      if pcall(require, 'mini.pick') then
        vim.keymap.set('n', 'gS', '<Cmd>Pick lsp scope="document_symbol"<cr>', { buffer = true })
      end
    end

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(false, client.id, bufnr, { autotrigger = false })
    end

    if client:supports_method('textDocument/prepareCallHierarchy') then
      if client:supports_method('callHierarchy/incomingCalls') then
        vim.keymap.set('n', 'g(', function() vim.lsp.buf.incoming_calls() end, { buffer = true })
      end
      if client:supports_method('callHierarchy/outgoingCalls') then
        vim.keymap.set('n', 'g)', function() vim.lsp.buf.outgoing_calls() end, { buffer = true })
      end
    end

    if client:supports_method('textDocument/inlayHint') then
      vim.keymap.set('n', 'yoh', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        vim.notify(string.format('Show inlay hints set to %s', vim.lsp.inlay_hint.is_enabled()), vim.log.INFO)
      end, { buffer = true })
    end
  end,
})
