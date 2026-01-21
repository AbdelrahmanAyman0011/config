return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]],
      direction = "float",
    })
    -- split screen shortcuts
    vim.keymap.set("n", "<C-\\>", ":ToggleTerm direction=horizontal<CR>")  -- Ctrl + \
    vim.keymap.set("n", "<C-]>", ":ToggleTerm direction=vertical<CR>")    -- Ctrl + ] 
  end,
}

