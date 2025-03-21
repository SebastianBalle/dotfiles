vim.g.mapleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "LazyVim/LazyVim",
    },
    { import = "custom/plugins" },
    { import = "custom/plugins/ai" },
  },
  checker = {
    enabled = true,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
})

require("custom.timetracker")
-- require("custom.nix-develop")
