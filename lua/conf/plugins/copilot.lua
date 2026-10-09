return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
      vim.g.copilot_no_tab_map = true
    end,
    config = function()
      vim.keymap.set("i", "<M-w>", "<Plug>(copilot-accept-word)", {
        desc = "Copilot: accept word",
        silent = true,
      })
      vim.keymap.set("i", "<M-l>", "<Plug>(copilot-accept-line)", {
        desc = "Copilot: accept line",
        silent = true,
      })
      vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept-line)", {
        desc = "Copilot: accept line",
        silent = true,
      })
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", {
        desc = "Copilot: dismiss suggestion",
        silent = true,
      })
      vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", {
        desc = "Copilot: next suggestion",
        silent = true,
      })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", {
        desc = "Copilot: previous suggestion",
        silent = true,
      })
    end,
  }
}
