local tabufline = require("nvchad.tabufline")
local theme_picker = require("nvchad.themes")
local nvimtree = require("nvim-tree.api")

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

local restart_last_task = function()
  local overseer = require("overseer")
  local tasks = overseer.list_tasks({ recent_first = true })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    overseer.run_action(tasks[1], "restart")
  end
end

require("which-key").add({
  ---- LSP-related mappings are in lua/configs/lspconfig.lua
  ---- NvimTree mappings are in lua/configs/nvimtree.lua

  ---- General
  {
    mode = { "n" },
    group = "General",

    { "<leader>q", "<cmd>q<cr>",   desc = "Quit" },
    { "<leader>Q", "<cmd>x<cr>",   desc = "Save & quit" },
    { "<leader>w", "<cmd>w<cr>",   desc = "Save" },
    { "<esc>",     "<cmd>noh<cr>", desc = "Clear highlights" },
    { "H", "^",                    desc = "Line begin" },
    { "L", "$",                    desc = "Line end" },
    { "<leader>h", "<C-w>h",       desc = "Split > left" },
    { "<leader>j", "<C-w>j",       desc = "Split > down" },
    { "<leader>k", "<C-w>k",       desc = "Split > up" },
    { "<leader>l", "<C-w>l",       desc = "Split > right" },
  },

  ---- Splits
  {
    mode = { "n" },
    group = "Splits",

    { "<leader>s",                                 desc = "Splits" },
    { "<leader>ss", "<cmd>split<cr>",              desc = "New horizontal split" },
    { "<leader>sv", "<cmd>vsplit<cr>",             desc = "New vertical split" },
    { "<leader>sc", "<cmd>close<cr>",              desc = "Close current split" },
    { "<C-h>",      "<cmd>vertical resize -5<cr>", desc = "Resize left" },
    { "<C-j>",      "<cmd>resize +5<cr>",          desc = "Resize up" },
    { "<C-k>",      "<cmd>resize -5<cr>",          desc = "Resize down" },
    { "<C-l>",      "<cmd>vertical resize +5<cr>", desc = "Resize right" },
  },

  ---- Buffers
  {
    mode = { "n" },
    group = "Buffers",

    { "<leader>b",                                desc = "Buffers" },
    { "<leader>ba", "<cmd>Telescope buffers<cr>", desc = "List of buffers" },
    { "<leader>bn", "<cmd>enew<cr>",              desc = "New buffer" },
    { "<leader>bc", tabufline.close_buffer,       desc = "Close current buffer" },
    { "<leader>bo", close_other_buffers,          desc = "Close all other buffers" },
    -- { "<leader>bh", tabufline.prev,               desc = "Previous buffer" },
    -- { "<leader>bl", tabufline.next,               desc = "Next buffer" },
    { "<S-Tab>",    tabufline.prev,               desc = "Previous buffer" },
    { "<Tab>",      tabufline.next,               desc = "Next buffer" },
  },

  ---- Find
  {
    mode = { "n" },
    group = "",

    { "<leader>f",                                   desc = "Find" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
  },

  ---- Git
  {
    mode = { "n" },
    group = "Git",

    { "<leader>v",                                    desc = "Git" },
    { "<leader>vc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
    { "<leader>vs", "<cmd>Telescope git_status<cr>",  desc = "Status" },
  },

  ---- Runner
  {
    mode = { "n" },
    group = "Runner",

    { "<leader>r",                             desc = "Runner" },
    { "<leader>rt", restart_last_task,         desc = "Run last task" },
    { "<leader>ra", "<cmd>OverseerRun<cr>",    desc = "Run a task" },
    { "<leader>rr", "<cmd>OverseerToggle<cr>", desc = "Toggle runner" },
  },

  ---- Settings
  {
    mode = { "n" },
    group = "Settings",

    { "<leader>.",                     desc = "Settings" },
    { "<leader>.t", theme_picker.open, desc = "Themes" },
    {
      "<leader>.d",
      "<cmd>e ~/.config/nvim/<cr>",
      desc = "Open config dir"
    },
  },
})
