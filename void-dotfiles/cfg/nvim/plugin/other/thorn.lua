-- ============================================================================== #
-- Thorn:                                                                         #
-- ============================================================================== #
Config.now(function()
  vim.pack.add({ { src = 'https://github.com/jpwol/thorn.nvim', version = 'refactor/theme-change' } })
  require('thorn').setup({
    on_highlights = function(hl, p)
      hl.PmenuSel = { bg = p.cursorline, bold = true }
      hl.TreesitterContextLineNumber = { fg = p.number, bg = p.bg_float }
      hl.LeapLabel = { fg = p.bg, bg = p.orange, bold = true }
      hl.MiniStatuslineDirectory = { bg = p.statusbar.bg, fg = p.gray }
      hl.MiniStatuslineFilename = { bg = p.statusbar.bg, fg = p.gray, bold = true }
    end,
  })
  vim.cmd.colorscheme('thorn')
end)
