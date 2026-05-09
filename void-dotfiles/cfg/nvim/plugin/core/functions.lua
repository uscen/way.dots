-- ============================================================================== #
-- Functions:                                                                     #
-- ============================================================================== #
Config.now(function()
  -- ============================================================================== #
  -- Debug Utils:                                                                   #
  -- ============================================================================== #
  Config.dd = function(...) vim.notify(vim.iter({ ... }):map(vim.inspect):join(', ')) end

  -- ============================================================================== #
  -- Random choice:                                                                 #
  -- ============================================================================== #
  math.randomseed(os.time())
  Config.choose = function(choices) return choices[math.random(1, #choices)] end

  -- ============================================================================== #
  -- Highlight groups:                                                              #
  -- ============================================================================== #
  -- Return info for hl_name or nil if it does not exist.
  Config.get_hl = function(hl_name)
    local hl_info = vim.api.nvim_get_hl(0, { name = hl_name, link = false })
    return not vim.tbl_isempty(hl_info) and hl_info or nil
  end

  -- ============================================================================== #
  -- Scratch Buffer:                                                                #
  -- ============================================================================== #
  -- Open a new scratch buffer in the current window. This differs from
  -- `:enew` in that it creates a new empty buffer rather than reusing
  -- the existing empty buffer if one exists. It also sets the buffer to
  -- be a scratch buffer (i.e. not listed, not saved to disk).
  Config.new_scratch_buffer = function() vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true)) end

  -- ============================================================================== #
  -- Re-map Binding:                                                                #
  -- ============================================================================== #
  Config.remap = function(mode, lhs_from, lhs_to)
    local keymap = vim.fn.maparg(lhs_from, mode, false, true)
    local rhs = keymap.callback or keymap.rhs
    if rhs == nil then error('Could not remap from ' .. lhs_from .. ' to ' .. lhs_to) end
    vim.keymap.set(mode, lhs_to, rhs, { desc = keymap.desc })
  end
end)
