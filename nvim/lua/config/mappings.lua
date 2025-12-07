local wk = require "which-key"

local close_other_buffers = function()
  local current_buf = vim.fn.bufnr()
  local current_win = vim.fn.win_getid()
  local bufs = vim.fn.getbufinfo({buflisted = 1})
  for _, buf in ipairs(bufs) do
    if buf.bufnr ~= current_buf then
      vim.cmd("silent! bdelete " .. buf.bufnr)
    end
  end
  vim.fn.win_gotoid(current_win)
end

-- mappings
wk.add({
  -- General
  {
    mode = { "n" },

    { "<leader>q", "<cmd>q<cr>",   desc = "Quit" },
    { "<leader>Q", "<cmd>x<cr>",   desc = "Save & quit" },
    { "<leader>w", "<cmd>w<cr>",   desc = "Save" },
    { "<esc>",     "<cmd>noh<cr>", desc = "Clear highlights" },
  },
  {
    mode = { "n", "v" },

    { "H", "^", desc = "Line begin" },
    { "L", "$", desc = "Line end" },
  },

  -- Splits
  {
    mode  = { "n" },

    { "<leader>s",                                 desc = "Splits" },
    { "<leader>ss", "<cmd>split<cr>",              desc = "New horizontal split" },
    { "<leader>sv", "<cmd>vsplit<cr>",             desc = "New vertical split" },
    { "<leader>sh", "<C-w>h",                      desc = "Split > left" },
    { "<leader>sj", "<C-w>j",                      desc = "Split > down" },
    { "<leader>sk", "<C-w>k",                      desc = "Split > up" },
    { "<leader>sl", "<C-w>l",                      desc = "Split > right" },
    { "<leader>sc", "<cmd>close<cr>",              desc = "Close current split" },
    { "<C-h>",      "<cmd>vertical resize -5<cr>", desc = "Resize left" },
    { "<C-j>",      "<cmd>resize +5<cr>",          desc = "Resize up" },
    { "<C-k>",      "<cmd>resize -5<cr>",          desc = "Resize down" },
    { "<C-l>",      "<cmd>vertical resize +5<cr>", desc = "Resize right" },
  },

  -- Buffers
  {
    mode  = { "n" },

    { "<leader>b",                       desc = "Buffers" },
    { "<leader>bn", "<cmd>enew<cr>",     desc = "New buffer" },
    { "<leader>bc", "<cmd>bd<cr>",       desc = "Close current buffer" },
    { "<leader>bo", close_other_buffers, desc = "Close all other buffers" },
    { "<S-Tab>",    "<cmd>bprev<cr>",    desc = "Previous buffer" },
    { "<Tab>",      "<cmd>bnext<cr>",    desc = "Next buffer" },
  },

  -- Tools
  {
    mode  = { "n" },

    { "<leader>t", desc = "Tools" },
    -- see more in plugin-related configs
  },

  -- Find
  {
    mode = { "n" },

    { "<leader>f",                                   desc = "Find" },
    -- see more in plugin-related configs
  },

  -- Settings
  {
    mode  = { "n" },

    { "<leader>.",                   desc = "Settings" },
    { "<leader>.l", "<cmd>Lazy<cr>", desc = "Lazy" },
    -- see more in plugin-related configs
  }

})
