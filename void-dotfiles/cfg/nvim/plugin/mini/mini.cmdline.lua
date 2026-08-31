-- ============================================================================== #
-- Cmdline:                                                                       #
-- ============================================================================== #
Config.later(function()
  local MiniCmdline = require('mini.cmdline')
  MiniCmdline.setup({ autocomplete = { delay = 200 }, autopeek = { n_context = 1 } })
end)
