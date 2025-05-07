-- require("nvchad.configs.lspconfig").defaults()
local lspconfig = require "lspconfig"

local servers = {
  "lua_ls",
  "pyright",
  "clangd",
  "gopls",
  "html",
  "cssls",
}
local nvlsp = require "nvchad.configs.lspconfig"

local on_attach = function(client, bufnr)
  -- nvlsp.on_attach(client, bufnr)

  require("which-key").add({
    ---- Go to
    {
      mode = { "n" },
      group = "Go to",

      { "<leader>g", desc = "Go to" },
      { "<leader>gt", vim.lsp.buf.declaration,    desc = "Type definition" },
      { "<leader>gd", vim.lsp.buf.definition,     desc = "Definition" },
      { "<leader>gi", vim.lsp.buf.implementation, desc = "Implementation" },
      { "<leader>gr", vim.lsp.buf.references,     desc = "References" },
    },

    ---- Code actions
    {
      mode = { "n" },
      group = "Code actions",

      { "<leader>a",                                desc = "Code actions" },
      { "<leader>aa", vim.lsp.buf.code_action,      desc = "All actions" },
      { "<leader>as", vim.lsp.buf.signature_help,   desc = "Show signature" },
      { "<leader>ar", require "nvchad.lsp.renamer", desc = "Rename" },
    },
  })
end

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end
