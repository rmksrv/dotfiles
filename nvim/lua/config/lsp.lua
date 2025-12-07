local wk = require "which-key"

-- Mason
-- mapping global
wk.add({
  {
    mode  = { "n" },

    { ".m", "<cmd>Mason<cr>", desc = "Mason" },
  },

})

-- Python
vim.lsp.enable("pyright")
