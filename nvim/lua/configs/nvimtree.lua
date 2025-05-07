local api = require "nvim-tree.api"
local wk = require "which-key"

local nvimtree_focus_hide = function()
  if vim.fn.bufname():match 'NvimTree_' then
    api.tree.toggle()
  else
    api.tree.focus()
  end
end

local function my_on_attach(bufnr)

  local function opts(desc)
    return { 
      desc = "NvimTree: " .. desc, 
      buffer = bufnr, 
      noremap = true, 
      silent = true, 
      nowait = true 
    }
  end

  -- default mappings
  -- api.config.mappings.default_on_attach(bufnr)

  -- custom mappings (which-key is not working here)
  vim.keymap.set("n", "?",     api.tree.toggle_help, opts("toggle"))
  vim.keymap.set("n", "e",     nvimtree_focus_hide,  opts("toggle"))
  vim.keymap.set("n", "<CR>",  api.node.open.edit,   opts("open"))
  vim.keymap.set("n", "<Tab>", api.marks.toggle,     opts("select"))
  ---- Deletion
  vim.keymap.set("n", "dd", api.fs.remove,         opts("delete this"))
  vim.keymap.set("n", "ds", api.marks.bulk.delete, opts("delete selected"))
  ---- Move
  vim.keymap.set("n", "ms", api.marks.bulk.move, opts("move selected"))
  ---- Other
  vim.keymap.set("n", "a", api.fs.create, opts("create"))
  vim.keymap.set("n", "x", api.fs.cut,    opts("cut"))
  vim.keymap.set("n", "p", api.fs.paste,  opts("paste"))
  vim.keymap.set("n", "r", api.fs.rename, opts("rename"))
end

require("nvim-tree").setup {
  on_attach = my_on_attach,
  filters = {
    dotfiles = false,
  },
}

wk.add({
  {
    mode = { "n" },
    group = "NvimTree",

    { "e", nvimtree_focus_hide, desc = "NvimTree: Toggle" },
  },
})
