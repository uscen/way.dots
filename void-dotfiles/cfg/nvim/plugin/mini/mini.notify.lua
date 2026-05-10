-- ============================================================================== #
-- Notify:                                                                        #
-- ============================================================================== #
Config.later(function()
  local MiniNotify = require('mini.notify')
  MiniNotify.setup({
    lsp_progress = { enable = false, duration_last = 500 },
    window = {
      config = function()
        local has_statusline = vim.o.laststatus > 0
        local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
        return { anchor = 'SE', col = 0, row = vim.o.lines - pad }
      end,
      max_width_share = 0.75,
      winblend = 15,
    },
  })
  vim.notify = MiniNotify.make_notify()
end)
