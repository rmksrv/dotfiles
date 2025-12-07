local wk = require "which-key"

-- mini.completion
--
require("mini.completion").setup({
  mappings = {
    -- Force two-step/fallback completions
    force_twostep = '<C-Space>',
    force_fallback = '<A-Space>',

    -- Scroll info/signature window down/up. When overriding, check for
    -- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
    -- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
    scroll_down = 'J',
    scroll_up = 'K',
  },
})

-- mapping global
wk.add({
  {
    mode  = { "i" },

    { "<Tab>",   [[pumvisible() ? "\<C-n>" : "\<Tab>"]],   desc = "Next suggestion", expr = true },
    { "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], desc = "Prev suggestion", expr = true },
  },

})



-- mini.pairs
--
require("mini.pairs").setup()


-- mini.cmdline
--
require("mini.cmdline").setup()


-- mini.icons
--
require("mini.icons").setup()


-- mini.tabline
--
require("mini.tabline").setup()

local function render_tabline_more_buffers()
  --[[ 
  Render Tabline only when there are >= 2 opened buffers
  ]]
  local bufs = vim.fn.getbufinfo({ buflisted = 1 })
  if #bufs <= 1 then
    vim.opt.showtabline = 0
  else
    vim.opt.showtabline = 2
  end
end

vim.api.nvim_create_autocmd(
  { "BufAdd", "BufDelete", "BufEnter" }, 
  { callback = render_tabline_more_buffers }
)


-- mini.statusline
--
require("mini.statusline").setup()


-- mini.files
--
require("mini.files").setup({
  mappings = {
    go_in       = '',  -- custom behavior below
    go_in_plus  = '<enter>',
    go_out      = 'h',
    go_out_plus = '',
  },
  windows = {
    max_number    = 3,
    preview       = false,
    width_focus   = 30,
    width_nofocus = 20,
    width_preview = 60,
  },
})

-- change 'go_in' behavior
local GO_IN_KEY = 'l'

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesBufferCreate',
  callback = function(args)
    local buf_id = args.data.buf_id
    vim.keymap.set(
      'n', 
      GO_IN_KEY, 
      function()
        local entry = MiniFiles.get_fs_entry()
        if not entry then
          return
        end

        if entry.fs_type == 'directory' then
          MiniFiles.go_in()
        end

      end, 
      { buffer = buf_id, nowait = true, silent = true }
    )
  end,
})

-- mapping global
wk.add({
  {
    mode  = { "n" },

    { "<leader>te", "<cmd>lua MiniFiles.open()<cr>", desc = "Explorer" },
  },

})

-- adjust explorer window
local mf_group = vim.api.nvim_create_augroup('MiniFilesLayout', { clear = true })

vim.api.nvim_create_autocmd('User', {
  group = mf_group,
  pattern = 'MiniFilesWindowUpdate',
  callback = function()
    local state = MiniFiles.get_explorer_state()
    if not state or not state.windows or vim.tbl_isempty(state.windows) then
      return
    end

    local ui = vim.api.nvim_list_uis()[1]
    if not ui then
      return
    end

    -- общая высота “модального окна”
    local height = math.floor(ui.height * 0.8)
    local row    = math.floor((ui.height - height) / 2)

    -- сначала считаем суммарную ширину всех колонок
    local total_width = 0
    local widths = {}

    for _, win_data in ipairs(state.windows) do
      local win_id = win_data.win_id
      if vim.api.nvim_win_is_valid(win_id) then
        local cfg = vim.api.nvim_win_get_config(win_id)
        if cfg.relative ~= '' then
          widths[win_id] = cfg.width
          total_width = total_width + cfg.width
        end
      end
    end

    if total_width == 0 then
      return
    end

    -- стартовая колонка так, чтобы вся гряда была по центру
    local start_col = math.floor((ui.width - total_width) / 2)
    local col = start_col

    -- раскладываем ВСЕ окна mini.files рядом
    for _, win_data in ipairs(state.windows) do
      local win_id = win_data.win_id
      if vim.api.nvim_win_is_valid(win_id) then
        local cfg = vim.api.nvim_win_get_config(win_id)
        if cfg.relative ~= '' then
          cfg.height = height
          cfg.row    = row
          cfg.col    = col

          vim.api.nvim_win_set_config(win_id, cfg)
          col = col + (widths[win_id] or cfg.width or 0)
        end
      end
    end
  end,
})
