-- astrodark, the dark theme from github.com/sampsn/dev-env-config (AstroNvim's astrotheme)
return {
  "AstroNvim/astrotheme",
  lazy = false,
  priority = 1000,
  opts = { palette = "astrodark" },
  config = function(_, opts)
    require("astrotheme").setup(opts)
    if vim.o.background == "dark" then
      vim.cmd.colorscheme("astrodark")
    end
  end,
}
