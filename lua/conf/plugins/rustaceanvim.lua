return {
  'mrcjkb/rustaceanvim',
  version = '^5',
  ft = { "rust" },
  init = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = function(client, bufnr)
          -- Enable inlay hints
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
          end

          vim.keymap.set("n", "<leader>cr", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "Rust Runnables", buffer = bufnr })
          vim.keymap.set("n", "<leader>ca", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Rust Code Action", buffer = bufnr })
          vim.keymap.set("n", "<leader>ce", function()
            vim.cmd.RustLsp("explainError")
          end, { desc = "Rust Explain Error", buffer = bufnr })
          vim.keymap.set("n", "<leader>em", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Rust Expand Macro", buffer = bufnr })
          
          -- Optional: If you want to use rustaceanvim's hover instead of standard LSP hover
          vim.keymap.set("n", "K", function()
            vim.cmd.RustLsp { "hover", "actions" }
          end, { desc = "Rust Hover Actions", buffer = bufnr })
        end,
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "by_self",
            },
            cargo = {
              loadOutDirsFromCheck = true,
              targetDir = true,
            },
            procMacro = {
              enable = true,
            },
            files = {
              excludeDirs = {
                "_build", ".dart_tool", ".flatpak-builder", ".git", ".sl",
                ".gitlab", ".gitlab-ci", ".gradle", ".idea", ".next",
                ".project", ".scannerwork", ".settings", ".venv",
                "archetype-resources", "bin", "hooks", "node_modules",
                "po", "screenshots", "target",
              },
            },
          },
        },
      },
    }
  end,
}
