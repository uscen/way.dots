-- ============================================================================== #
-- Snippets:                                                                      #
-- ============================================================================== #
Config.later(function()
  local MiniSnippets    = require('mini.snippets')
  -- Languge Patterns: ===========================================================================
  local config_path     = vim.fn.stdpath('config')
  local latex_patterns  = { 'latex/**/*.json', '**/latex.json' }
  local markdown        = { 'markdown.json' }
  local webHtmlPatterns = { 'html.json', 'ejs.json' }
  local webJsPatterns   = { 'web/javascript.json' }
  local webTsPatterns   = { 'web/typescript.json' }
  local webAllPatterns  = { 'web/*.json' }
  local lang_patterns   = {
    tex = latex_patterns,
    markdown_inline = markdown,
    html = webHtmlPatterns,
    ejs = webHtmlPatterns,
    javascript = webAllPatterns,
    typescript = webAllPatterns,
    javascriptreact = webPatterns,
    typescriptreact = webPatterns,
  }

  -- Expand Patterns: ============================================================================
  local match_strict    = function(snips)
    -- Do not match with whitespace to cursor's left =============================================
    -- return MiniSnippets.default_match(snips, { pattern_fuzzy = '%S+' })
    -- Match exact from the start to the end of the string =======================================
    return MiniSnippets.default_match(snips, { pattern_fuzzy = '^%S+$' })
  end

  -- Setup Snippets ==============================================================================
  MiniSnippets.setup({
    snippets = {
      MiniSnippets.gen_loader.from_file(config_path .. '/snippets/global.json'),
      MiniSnippets.gen_loader.from_lang({ lang_patterns = lang_patterns }),
    },
    mappings = { expand = '<C-e>', jump_next = '<C-l>', jump_prev = '<C-h>', stop = '<C-c>' },
    expand   = {
      match = match_strict,
      insert = function(snippet)
        return MiniSnippets.default_insert(snippet, { empty_tabstop = '', empty_tabstop_final = '†' })
      end,
    },
  })

  -- Expand Snippets Or complete by Tab ==========================================================
  local expand_or_complete = function()
    if #MiniSnippets.expand({ insert = false }) > 0 then
      vim.schedule(MiniSnippets.expand); return ''
    end
    return vim.fn.pumvisible() == 1 and
        (vim.fn.complete_info().selected == -1 and vim.keycode('<c-n><c-y>') or vim.keycode('<c-y>')) or '<Tab>'
  end
  vim.keymap.set('i', '<Tab>', expand_or_complete, { expr = true, replace_keycodes = true })

  -- Exit snippet sessions on entering normal mode: ==============================================
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniSnippetsSessionStart',
    callback = function()
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:n',
        once = true,
        callback = function()
          while MiniSnippets.session.get() do
            MiniSnippets.session.stop()
          end
        end,
      })
    end,
  })

  -- Exit snippets upon reaching final tabstop: ==================================================
  vim.api.nvim_create_autocmd('User', {
    pattern = 'MiniSnippetsSessionJump',
    callback = function(args)
      if args.data.tabstop_to == '0' then MiniSnippets.session.stop() end
    end,
  })
end)
