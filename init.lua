-- NEOVIDE CURSOR (Neovide-Cursor)
if vim.g.neovide then
  vim.o.guifont = "JetBrains Mono:h11" -- Exact system name from fc-list
  vim.g.neovide_cursor_animation_length = 0.13
  vim.g.neovide_cursor_trail_size = 0.8
  vim.g.neovide_cursor_antialiasing = true
  vim. g.neovide_cursor_vfx_mode = "railgun"
end

require "conf"

-- Ensure transparent background
vim.cmd([[
augroup user_colors
  autocmd!
  autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
augroup END
]])
