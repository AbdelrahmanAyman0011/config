return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha", -- Deep, rich dark theme
      transparent_background = false,
      styles = {
        comments = { "italic" },
        conditionals = { "bold" },
        loops = { "bold" },
        functions = { "bold" },
        keywords = { "bold" },
        strings = {},
        variables = {},
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "bold" },
        operators = {},
      },
      custom_highlights = function(colors)
        return {
          -- IDE-style bold syntax (NetBeans / IntelliJ / Code::Blocks feel)
          ["@keyword"] = { fg = colors.mauve, bold = true },
          ["@keyword.function"] = { fg = colors.mauve, bold = true },
          ["@keyword.return"] = { fg = colors.mauve, bold = true },
          ["@keyword.operator"] = { fg = colors.mauve, bold = true },
          ["@keyword.conditional"] = { fg = colors.mauve, bold = true },
          ["@keyword.repeat"] = { fg = colors.mauve, bold = true },
          ["@keyword.import"] = { fg = colors.mauve, bold = true },
          ["@keyword.storage"] = { fg = colors.yellow, bold = true },
          ["@type"] = { fg = colors.yellow, bold = true },
          ["@type.builtin"] = { fg = colors.yellow, bold = true },
          ["@type.definition"] = { fg = colors.yellow, bold = true },
          ["@type.qualifier"] = { fg = colors.mauve, bold = true },
          ["@boolean"] = { fg = colors.peach, bold = true },
          ["@constant.builtin"] = { fg = colors.peach, bold = true },
          ["@function"] = { fg = colors.blue, bold = true },
          ["@function.method"] = { fg = colors.blue, bold = true },
          ["Keyword"] = { bold = true },
          ["Type"] = { bold = true },
          ["StorageClass"] = { bold = true },
          ["Structure"] = { bold = true },
          ["Typedef"] = { bold = true },
          ["Boolean"] = { bold = true },
          ["Statement"] = { bold = true },
          ["Conditional"] = { bold = true },
          ["Repeat"] = { bold = true },
        }
      end,
    })
  end,
}
