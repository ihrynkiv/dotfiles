return {
  -- CSS / HTML / SCSS LSP (not covered by any LazyVim extra)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cssls = {},
        html = {},
      },
    },
  },

  -- Auto-install css-lsp and html-lsp via mason
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "css-lsp",
        "html-lsp",
        "prettier", -- fallback formatter for files biome doesn't cover
      },
    },
  },

  -- Prettier as fallback formatter for HTML/CSS/GraphQL
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        graphql = { "prettier" },
      },
    },
  },

  -- Better TypeScript errors (inline virtual text for long TS errors)
  {
    "OlegGulevskyy/better-ts-errors.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = { "typescript", "typescriptreact" },
    opts = {
      keymaps = {
        toggle = "<leader>dd", -- toggle pretty TS error panel
      },
    },
  },

  -- Package.json: show npm package versions inline
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    config = function()
      require("package-info").setup()
      -- Show versions on package.json open
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "package.json",
        callback = function()
          require("package-info").show()
        end,
      })
    end,
    keys = {
      { "<leader>np", "<cmd>lua require('package-info').toggle()<cr>", desc = "Toggle package versions" },
      { "<leader>nu", "<cmd>lua require('package-info').update()<cr>", desc = "Update package" },
      { "<leader>ni", "<cmd>lua require('package-info').install()<cr>", desc = "Install new package" },
    },
  },
}
