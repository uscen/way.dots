-- ============================================================================== #
-- Diff:                                                                          #
-- ============================================================================== #
Config.later(function()
  local MiniDiff = require('mini.diff')
  require('mini.diff').setup({ view = { style = 'number', signs = { add = '▎', change = '▎', delete = '▎' } } })
  Config.minidiff_to_qf = function()
    vim.fn.setqflist(MiniDiff.export('qf'))
    vim.cmd('copen')
  end
end)
