-- ============================================================================== #
-- Move:                                                                          #
-- ============================================================================== #
Config.later(function()
  local MiniMove = require('mini.move')
  MiniMove.setup({ mappings = { left = '<S-h>', right = '<S-l>', down = '<S-j>', up = '<S-k>' } })
end)
