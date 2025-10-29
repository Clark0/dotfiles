return { -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "clangd",
      },
    },
  },

  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ['*'] = {
          keys = {
            { "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", has = "Hover" },
          },
        },
      },
    },
  },
}
