return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "DaikyXendo/nvim-material-icon",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "NeoTree toggle" } },
  },
  opts = {
    close_if_last_window = true,
    auto_clean_after_session_restore = true,
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      filtered_items = {
        hide_hidden = false,
        hide_dotfiles = false,
        force_visible_in_empty_folder = true,
        hide_gitignored = false,
      },
    },
    window = {
      position = "right",
      auto_expand_width = true,
      width = 35,
    },
    default_component_configs = {
      diagnostics = {
        symbols = {
          hint = "",
          info = "",
          warn = "",
          error = "",
        },
        highlights = {
          hint = "DiagnosticSignHint",
          info = "DiagnosticSignInfo",
          warn = "DiagnosticSignWarn",
          error = "DiagnosticSignError",
        },
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
