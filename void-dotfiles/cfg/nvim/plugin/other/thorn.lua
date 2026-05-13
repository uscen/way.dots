-- ============================================================================== #
-- Thorn:                                                                         #
-- ============================================================================== #
Config.now(function()
  vim.pack.add({ 'https://github.com/jpwol/thorn.nvim' })
  require('thorn').setup({
    on_highlights = function(hl, p)
      hl.MiniStatuslineDirectory = { bg = p.statusbar.bg, fg = p.gray }
      hl.MiniStatuslineFilename = { bg = p.statusbar.bg, fg = p.gray, bold = true }
    end,
  })
  vim.cmd.colorscheme('thorn')
end)
