return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "latte", -- Light blue theme!  (bashbunni's choice)
      transparent_background = false, -- Set to false for light theme
    })
   -- vim.cmd([[colorscheme catppuccin]])
  end,
}
