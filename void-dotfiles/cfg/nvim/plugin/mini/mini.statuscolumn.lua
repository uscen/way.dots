-- ============================================================================== #
-- Statuscolumn:                                                                  #
-- ============================================================================== #
Config.now(function()
  local MiniStatuscolumn = require('mini.statuscolumn')
  local spec = {
    { format = 's=l=', sep = '▏' },
    { ltype = 'virt', lnum = '•' },
    { ltype = 'wrap', lnum = '↳' },
    { win = 'inactive', sep = ' ' },
  }
  MiniStatuscolumn.setup({ content = MiniStatuscolumn.gen_content.main(spec) })
end)
