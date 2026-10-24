-- Rainbow brackets, rainbow indent guides, and an animated current-scope line.
-- Colors are fixed (not theme-derived) so they survive :colorscheme switches.
local colors = {
  RainbowRed = "#E06C75",
  RainbowYellow = "#E5C07B",
  RainbowBlue = "#61AFEF",
  RainbowOrange = "#D19A66",
  RainbowGreen = "#98C379",
  RainbowViolet = "#C678DD",
  RainbowCyan = "#56B6C2",
}
local order = { "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan" }

local function define_highlights()
  for name, fg in pairs(colors) do
    vim.api.nvim_set_hl(0, name, { fg = fg })
    -- dimmed variant for indent guides
    local n = tonumber(fg:sub(2), 16)
    local r, g, b = math.floor(n / 65536) % 256, math.floor(n / 256) % 256, n % 256
    vim.api.nvim_set_hl(0, name .. "Dim", { fg = string.format("#%02x%02x%02x", r * 0.45, g * 0.45, b * 0.45) })
  end
  vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#E5C07B", bold = true })
end

return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      define_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", { callback = define_highlights })
      require("rainbow-delimiters.setup").setup({
        highlight = order,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- ibl re-creates its highlights on every :colorscheme; define ours in its own hook so
      -- they exist at that moment (an autocmd of ours would run too late and ibl would error).
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, define_highlights)
      define_highlights()
      local dim = vim.tbl_map(function(n) return n .. "Dim" end, order)
      require("ibl").setup({
        indent = { char = "│", highlight = dim },
        scope = { enabled = false }, -- mini.indentscope draws the animated scope
      })
    end,
  },
  {
    "nvim-mini/mini.indentscope",
    version = false,
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local is = require("mini.indentscope")
      is.setup({
        symbol = "│",
        draw = {
          delay = 0,
          animation = is.gen_animation.quadratic({ easing = "out", duration = 180, unit = "total" }),
        },
        options = { try_as_border = true },
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "lazy", "NvimTree", "TelescopePrompt", "toggleterm", "mason" },
        callback = function() vim.b.miniindentscope_disable = true end,
      })
    end,
  },
}
