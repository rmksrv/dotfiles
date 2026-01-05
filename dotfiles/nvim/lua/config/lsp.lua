local wk = require "which-key"

-- Mason
-- mapping global
wk.add({
  {
    mode  = { "n" },

    { "<leader>.m", "<cmd>Mason<cr>", desc = "Mason" },
  },

})

local lsps = {
    { "pyright" },
    { "rust-analyzer" },
    { "ts_ls" },
    { "haskell-language-server" },
}


for _, lsp in pairs(lsps) do
    local name, config = lsp[1], lsp[2]
    vim.lsp.enable(name)
    if config then
        vim.lsp.config(name, config)
    end
end
