-- ============================================================================== #
-- Diagnostics:                                                                   #
-- ============================================================================== #
local diagnostic_opts = {
  severity_sort = true,
  update_in_insert = false,
  virtual_lines = false,
  signs = false,
  underline = { severity = { min = 'HINT', max = 'ERROR' } },
  float = {
    prefix = '󱓇  ',
    source = 'if_many',
    style = 'minimal',
    border = 'single',
    header = '',
    title = 'Diagnostics:',
    title_pos = 'left',
    max_height = 10,
    max_width = 130,
    focusable = false,
    close_events = { 'CursorMoved', 'BufLeave', 'WinLeave', 'InsertEnter' },
  },
  virtual_text = {
    spacing = 2,
    highlight = false,
    prefix = '▎',
    source = 'if_many',
    virt_text_pos = 'eol_right_align',
    current_line = true,
    severity = { min = 'ERROR', max = 'ERROR' },
    format = function(diagnostic)
      local icon = '→ '
      local message = vim.split(diagnostic.message, '\n')[1]
      return ('%s %s '):format(icon, message)
    end,
  },
}
vim.diagnostic.config(diagnostic_opts)
