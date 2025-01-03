vim.keymap.set("t", "<esc>", "<c-\\><c-n>")

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf
  if opts.buf and vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    focusable = true,
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function start_dim()
  require("vimade").setup({
    ncmode = "windows",
    fadelevel = 0.2,
    tint = {
      bg = { rgb = { 0, 0, 0 }, intensity = 0.2 },
    },
  })
  vim.cmd("VimadeEnable")
end

local function stop_dim()
  vim.cmd("VimadeDisable")
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    start_dim()

    state.floating = create_floating_window({ buf = state.floating.buf })

    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd("terminal zsh")
      vim.api.nvim_feedkeys("i", "n", false)
    end

    -- Set buffer options to prevent switching
    vim.bo[state.floating.buf].bufhidden = "wipe"
    vim.api.nvim_buf_set_keymap(state.floating.buf, "n", "<C-h>", "<nop>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(state.floating.buf, "n", "<C-j>", "<nop>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(state.floating.buf, "n", "<C-k>", "<nop>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(state.floating.buf, "n", "<C-l>", "<nop>", { noremap = true, silent = true })

    vim.api.nvim_create_autocmd("BufWipeout", {
      buffer = state.floating.buf,
      callback = function()
        state.floating = { buf = -1, win = -1 }
        stop_dim()
      end,
    })
  else
    vim.api.nvim_win_hide(state.floating.win)
    stop_dim()
  end
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    if vim.api.nvim_win_is_valid(state.floating.win) then
      vim.api.nvim_win_close(state.floating.win, true)
    end
    stop_dim()
  end,
})

vim.keymap.set({ "n", "t" }, "<C-t>", toggle_terminal, { desc = "Toggle floating terminal" })
