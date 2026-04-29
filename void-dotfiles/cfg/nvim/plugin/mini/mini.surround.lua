-- ============================================================================== #
-- Surround:                                                                      #
-- ============================================================================== #
Config.later(function()
  local MiniSurround = require('mini.surround')
  MiniSurround.setup({
    n_lines = 500,
    custom_surroundings = {
      ['('] = { output = { left = '(', right = ')' } },
      ['['] = { output = { left = '[', right = ']' } },
      ['{'] = { output = { left = '{', right = '}' } },
      ['<'] = { output = { left = '<', right = '>' } },
    },
    mappings = {
      add = 'ys',
      delete = 'ds',
      find = 'sf',
      find_left = 'sF',
      highlight = 'sh',
      replace = 'cs',
      update_n_lines = 'sn',
      suffix_last = 'l',
      suffix_next = 'n',
    },
  })
end)
