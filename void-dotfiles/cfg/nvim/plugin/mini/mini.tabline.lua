-- ============================================================================== #
-- Tabline:                                                                       #
-- ============================================================================== #
Config.now(function()
  local MiniTabline = require('mini.tabline')
  MiniTabline.setup({
    show_icons = true,
    tabpage_section = 'right',
    format = function(buf_id, label)
      local suffix = vim.bo[buf_id].modified and '● ' or ''
      return MiniTabline.default_format(buf_id, label) .. suffix
    end,
  })

  -- hide when only One Buffer: ==================================================================
  local get_n_listed_bufs = function()
    local n = 0
    for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
      n = n + (vim.bo[buf_id].buflisted and 1 or 0)
    end
    return n
  end
  Config.new_autocmd({ 'BufAdd', 'BufDelete' }, {
    callback = vim.schedule_wrap(function() vim.o.showtabline = get_n_listed_bufs() > 1 and 2 or 0 end),
  })
end)
