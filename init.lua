-- NEOVIDE (font/colors come from conf.options and the colorscheme)
if vim.g.neovide then
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_cursor_smooth_blink = true
  vim.g.neovide_position_animation_length = 0.15
  vim.g.neovide_scroll_animation_length = 0.25
  vim.g.neovide_scroll_animation_far_lines = 1
  vim.g.neovide_floating_corner_radius = 0.3
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_refresh_rate_idle = 5
  vim.g.neovide_cursor_vfx_mode = "railgun"

  -- Zoom: Ctrl+= / Ctrl+- / Ctrl+0 and Ctrl+scroll
  vim.g.neovide_scale_factor = 1.0
  local function zoom(factor)
    vim.g.neovide_scale_factor = math.max(0.3, math.min(5.0, vim.g.neovide_scale_factor * factor))
  end
  local map = vim.keymap.set
  map({ "n", "v", "i", "t" }, "<C-=>", function() zoom(1.1) end, { desc = "Neovide zoom in" })
  map({ "n", "v", "i", "t" }, "<C-+>", function() zoom(1.1) end, { desc = "Neovide zoom in" })
  map({ "n", "v", "i", "t" }, "<C-->", function() zoom(1 / 1.1) end, { desc = "Neovide zoom out" })
  map({ "n", "v", "i", "t" }, "<C-0>", function() vim.g.neovide_scale_factor = 1.0 end, { desc = "Neovide reset zoom" })
  map({ "n", "v", "i" }, "<C-ScrollWheelUp>", function() zoom(1.1) end, { desc = "Neovide zoom in" })
  map({ "n", "v", "i" }, "<C-ScrollWheelDown>", function() zoom(1 / 1.1) end, { desc = "Neovide zoom out" })
end

require "conf"
vim.opt.background = "dark"
vim.cmd("colorscheme retrobox")
