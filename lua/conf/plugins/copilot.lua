-- DISABLED (Gemini is used instead, see conf/gemini.lua). Copilot as an entry in the nvim-cmp popup ([Copilot]) next to LSP items,
-- instead of inline ghost text. Authenticate once with :Copilot auth
return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false }, -- no inline ghost text
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    enabled = false,
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
