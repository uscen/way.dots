-- ============================================================================== #
-- Neovide:                                                                       #
-- ============================================================================== #
if vim.g.neovide then
  -- General: ==================================================================================
  vim.o.guifont = 'JetBrainsMono Nerd Font:h12'
  vim.g.neovide_scale_factor = 1
  vim.g.neovide_refresh_rate = 120
  -- Appearance: ===============================================================================
  vim.g.neovide_opacity = 1
  vim.g.neovide_underline_stroke_scale = 2.5
  vim.g.neovide_show_border = false
  -- Padding: ==================================================================================
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0
  -- Floating: =================================================================================
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  -- Behavior: =================================================================================
  vim.g.neovide_remember_window_size = false
  vim.g.neovide_hide_mouse_when_typing = false
  vim.g.neovide_no_idle = false
  vim.g.neovide_cursor_smooth_blink = false
  vim.g.neovide_cursor_antialiasing = false
  vim.g.neovide_cursor_animate_in_insert_mode = false
  vim.g.neovide_cursor_animate_command_line = false
  -- Cursor: ===================================================================================
  vim.g.neovide_position_animation_length = 0
  vim.g.neovide_cursor_animation_length = 0.00
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_scroll_animation_far_lines = 0
  vim.g.neovide_scroll_animation_length = 0.00
  -- Options: ==================================================================================
  vim.o.mousescroll = 'ver:10,hor:6'
  vim.o.linespace = 0
  -- Keymap: ===================================================================================
  vim.keymap.set({ 'n', 'v' }, '<F11>', ':<C-u>let g:neovide_fullscreen = !g:neovide_fullscreen<CR>')
  vim.keymap.set({ 'n', 'v' }, '<C-=>', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<cr>')
  vim.keymap.set({ 'n', 'v' }, '<C-->', ':lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<cr>')
  vim.keymap.set({ 'n', 'v' }, '<C-0>', ':lua vim.g.neovide_scale_factor = 1<cr>')
end
