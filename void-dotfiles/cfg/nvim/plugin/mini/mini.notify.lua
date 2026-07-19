-- ============================================================================== #
-- Notifications:                                                                 #
-- ============================================================================== #
Config.now(function()
  require('mini.notify').setup({
    lsp_progress = { duration_last = 500 },
    window = {
      config = function()
        local has_statusline = vim.o.laststatus > 0
        local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
        return { anchor = 'SE', col = vim.o.columns, row = vim.o.lines - pad }
      end,
      max_width_share = 0.45,
    },
  })
end)
