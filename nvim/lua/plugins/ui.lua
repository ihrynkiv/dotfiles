return {
  -- Catppuccin is already installed by LazyVim; set it as default theme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Show git blame inline (like IntelliJ's annotate)
  {
    "f-person/git-blame.nvim",
    event = "BufReadPost",
    opts = {
      enabled = true,
      message_template = " <author> • <date> • <summary>",
      date_format = "%Y-%m-%d",
      virtual_text_column = 1,
    },
    keys = {
      { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Toggle git blame" },
    },
  },
}
