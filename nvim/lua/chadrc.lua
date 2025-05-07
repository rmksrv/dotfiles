-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "poimandres",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

vim.api.nvim_create_augroup("CasinoFileType", { clear = true })
vim.api.nvim_create_autocmd(
  {"BufRead", "BufNewFile"},
  {
    group = "CasinoFileType",
    pattern = "*.кз",
    callback = function()
      vim.bo.filetype = "casino"
    end,
  }
)

-- relative lines
vim.wo.relativenumber = true

require('overseer').setup()

return M
