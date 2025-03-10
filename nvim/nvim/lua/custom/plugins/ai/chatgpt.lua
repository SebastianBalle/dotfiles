return {
  "jackMort/ChatGPT.nvim",
  enabled = false, -- I do not believe the experience working with this is par simply copy/paste into ChatGPT website.
  keys = {
    { "<C-c>", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
  },
  config = function()
    require("chatgpt").setup({
      openai_params = {
        model = "gpt-4o-mini",
        temperature = 0.0,
      },
      api_key_cmd = "op read op://private/OpenAI/credential --no-newline",
    })
  end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "folke/trouble.nvim", -- optional
    "nvim-telescope/telescope.nvim",
  },
}